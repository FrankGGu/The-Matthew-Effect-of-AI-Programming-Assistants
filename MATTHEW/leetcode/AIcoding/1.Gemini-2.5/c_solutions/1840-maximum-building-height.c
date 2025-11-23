#include <stdlib.h> // For malloc, free, qsort, abs

#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))

typedef struct {
    int id;
    int maxHeight;
} Restriction;

int compareRestrictions(const void *a, const void *b) {
    return ((Restriction *)a)->id - ((Restriction *)b)->id;
}

int maxBuilding(int n, int** restrictions, int restrictionsSize, int* restrictionsColSize) {
    // Allocate memory for all restrictions, including the implicit building 0
    // restrictionsSize + 1 for the [0,0] restriction
    Restriction *allRestrictions = (Restriction *)malloc((restrictionsSize + 1) * sizeof(Restriction));

    // Add the implicit [0,0] restriction for building 0
    allRestrictions[0].id = 0;
    allRestrictions[0].maxHeight = 0;

    // Copy the given restrictions into our array, starting from index 1
    for (int i = 0; i < restrictionsSize; ++i) {
        allRestrictions[i+1].id = restrictions[i][0];
        allRestrictions[i+1].maxHeight = restrictions[i][1];
    }

    int count = restrictionsSize + 1; // Total number of restrictions including [0,0]

    // Sort all restrictions by building ID
    qsort(allRestrictions, count, sizeof(Restriction), compareRestrictions);

    // First pass: Left-to-right
    // Adjust maxHeight based on the previous building's height and the +1 rule.
    // For each building `i`, its height cannot exceed `height[i-1] + (id_i - id_{i-1})`.
    for (int i = 1; i < count; ++i) {
        allRestrictions[i].maxHeight = MIN(allRestrictions[i].maxHeight, 
                                            allRestrictions[i-1].maxHeight + (allRestrictions[i].id - allRestrictions[i-1].id));
    }

    // Second pass: Right-to-left
    // Adjust maxHeight based on the next building's height and the +1 rule.
    // For each building `i`, its height cannot exceed `height[i+1] + (id_{i+1} - id_i)`.
    for (int i = count - 2; i >= 0; --i) {
        allRestrictions[i].maxHeight = MIN(allRestrictions[i].maxHeight,
                                            allRestrictions[i+1].maxHeight + (allRestrictions[i+1].id - allRestrictions[i].id));
    }

    int max_overall_height = 0;

    // Calculate the maximum possible height for any building between adjacent restricted buildings
    for (int i = 0; i < count - 1; ++i) {
        int id_i = allRestrictions[i].id;
        int h_i = allRestrictions[i].maxHeight;
        int id_j = allRestrictions[i+1].id;
        int h_j = allRestrictions[i+1].maxHeight;

        // The maximum height for any building between (id_i, h_i) and (id_j, h_j)
        // forms a "tent" shape. The peak height of this tent is given by:
        // MAX(h_i, h_j) + ( (id_j - id_i) - abs(h_i - h_j) ) / 2
        int delta_id = id_j - id_i;
        int delta_h = abs(h_i - h_j);

        int peak_height = MAX(h_i, h_j) + (delta_id - delta_h) / 2;

        max_overall_height = MAX(max_overall_height, peak_height);
    }

    // Also consider the buildings after the last restricted building up to building 'n'.
    // The height can increase by 1 for each building.
    // The height of building 'n' could be `height[last_restricted_id] + (n - last_restricted_id)`.
    max_overall_height = MAX(max_overall_height, allRestrictions[count-1].maxHeight + (n - allRestrictions[count-1].id));

    // Free the dynamically allocated memory
    free(allRestrictions);

    return max_overall_height;
}