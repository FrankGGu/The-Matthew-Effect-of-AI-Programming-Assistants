#include <stdlib.h> // For malloc, free, realloc, qsort

static int* parent_dsu;

static int find_dsu(int i) {
    if (parent_dsu[i] == i)
        return i;
    return parent_dsu[i] = find_dsu(parent_dsu[i]);
}

static void unite_dsu(int i, int j) {
    int root_i = find_dsu(i);
    int root_j = find_dsu(j);
    if (root_i != root_j) {
        parent_dsu[root_j] = root_i;
    }
}

static int compareInts(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

struct ComponentValues {
    int* nums1_vals;
    int nums1_count;
    int nums1_capacity;

    int* nums2_vals;
    int nums2_count;
    int nums2_capacity;
};

int minimizeHammingDistance(int* nums1, int* nums2, int nums1Size, int** allowedSwaps, int allowedSwapsSize, int* allowedSwapsColSize) {
    int n = nums1Size;

    parent_dsu = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        parent_dsu[i] = i;
    }

    for (int i = 0; i < allowedSwapsSize; ++i) {
        unite_dsu(allowedSwaps[i][0], allowedSwaps[i][1]);
    }

    struct ComponentValues** components = (struct ComponentValues**)calloc(n, sizeof(struct ComponentValues*));

    for (int i = 0; i < n; ++i) {
        int root = find_dsu(i);

        if (components[root] == NULL) {
            components[root] = (struct ComponentValues*)malloc(sizeof(struct ComponentValues));
            components[root]->nums1_vals = NULL;
            components[root]->nums1_count = 0;
            components[root]->nums1_capacity = 0;
            components[root]->nums2_vals = NULL;
            components[root]->nums2_count = 0;
            components[root]->nums2_capacity = 0;
        }

        // Add nums1[i]
        if (components[root]->nums1_count == components[root]->nums1_capacity) {
            components[root]->nums1_capacity = components[root]->nums1_capacity == 0 ? 4 : components[root]->nums1_capacity * 2;
            components[root]->nums1_vals = (int*)realloc(components[root]->nums1_vals, components[root]->nums1_capacity * sizeof(int));
        }
        components[root]->nums1_vals[components[root]->nums1_count++] = nums1[i];

        // Add nums2[i]
        if (components[root]->nums2_count == components[root]->nums2_capacity) {
            components[root]->nums2_capacity = components[root]->nums2_capacity == 0 ? 4 : components[root]->nums2_capacity * 2;
            components[root]->nums2_vals = (int*)realloc(components[root]->nums2_vals, components[root]->nums2_capacity * sizeof(int));
        }
        components[root]->nums2_vals[components[root]->nums2_count++] = nums2[i];
    }

    int hammingDistance = 0;

    for (int i = 0; i < n; ++i) {
        if (components[i] != NULL) { // This 'i' is a root of a component
            struct ComponentValues* comp = components[i];

            qsort(comp->nums1_vals, comp->nums1_count, sizeof(int), compareInts);
            qsort(comp->nums2_vals, comp->nums2_count, sizeof(int), compareInts);

            int p1 = 0;
            int p2 = 0;
            int matches = 0;

            while (p1 < comp->nums1_count && p2 < comp->nums2_count) {
                if (comp->nums1_vals[p1] == comp->nums2_vals[p2]) {
                    matches++;
                    p1++;
                    p2++;
                } else if (comp->nums1_vals[p1] < comp->nums2_vals[p2]) {
                    p1++;
                } else { // comp->nums1_vals[p1] > comp->nums2_vals[p2]
                    p2++;
                }
            }
            hammingDistance += (comp->nums1_count - matches);
        }
    }

    free(parent_dsu);
    for (int i = 0; i < n; ++i) {
        if (components[i] != NULL) {
            free(components[i]->nums1_vals);
            free(components[i]->nums2_vals);
            free(components[i]);
        }
    }
    free(components);

    return hammingDistance;
}