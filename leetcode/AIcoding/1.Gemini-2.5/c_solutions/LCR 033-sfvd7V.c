#include <stdlib.h>
#include <string.h>
#include <stdio.h> // For qsort, strlen, strcpy, strcmp, malloc, realloc, free, strdup

int compareChars(const void* a, const void* b) {
    return (*(char*)a - *(char*)b);
}

typedef struct {
    char* sortedKey;    // Canonical key (sorted string) for this group
    char** strings;     // Array of original strings belonging to this group
    int count;          // Number of strings currently in this group
    int capacity;       // Current allocated capacity for the strings array
} AnagramGroup;

int findGroupIndex(AnagramGroup** groups, int groupsCount, const char* sortedKey) {
    for (int i = 0; i < groupsCount; i++) {
        if (strcmp(groups[i]->sortedKey, sortedKey) == 0) {
            return i;
        }
    }
    return -1;
}

char*** groupAnagrams(char** strs, int strsSize, int* returnSize, int** returnColumnSizes) {
    // Initial capacity for the array of AnagramGroup pointers
    int groupsCapacity = 8;
    AnagramGroup** groups = (AnagramGroup**)malloc(groupsCapacity * sizeof(AnagramGroup*));
    int groupsCount = 0; // Current number of distinct anagram groups

    for (int i = 0; i < strsSize; i++) {
        char* currentStr = strs[i];
        int len = strlen(currentStr);

        // Create a sorted version of the current string to use as a key
        char* sortedKey = (char*)malloc((len + 1) * sizeof(char));
        strcpy(sortedKey, currentStr);
        qsort(sortedKey, len, sizeof(char), compareChars);

        // Try to find an existing group for this sorted key
        int groupIndex = findGroupIndex(groups, groupsCount, sortedKey);

        if (groupIndex != -1) {
            // Group found: add the current string to this existing group
            AnagramGroup* group = groups[groupIndex];
            if (group->count == group->capacity) {
                // Resize the strings array if capacity is reached
                group->capacity *= 2;
                group->strings = (char**)realloc(group->strings, group->capacity * sizeof(char*));
            }
            group->strings[group->count++] = strdup(currentStr); // Duplicate the original string
            free(sortedKey); // The temporary sortedKey is no longer needed
        } else {
            // No group found: create a new group
            if (groupsCount == groupsCapacity) {
                // Resize the groups array if capacity is reached
                groupsCapacity *= 2;
                groups = (AnagramGroup**)realloc(groups, groupsCapacity * sizeof(AnagramGroup*));
            }

            AnagramGroup* newGroup = (AnagramGroup*)malloc(sizeof(AnagramGroup));
            newGroup->sortedKey = sortedKey; // Assign the newly created sortedKey to the group
            newGroup->count = 0;
            newGroup->capacity = 4; // Initial capacity for strings within this new group
            newGroup->strings = (char**)malloc(newGroup->capacity * sizeof(char*));

            newGroup->strings[newGroup->count++] = strdup(currentStr); // Duplicate and add the original string

            groups[groupsCount++] = newGroup; // Add the new group to the list of groups
        }
    }

    // Prepare the final result in the LeetCode required format
    *returnSize = groupsCount;
    *returnColumnSizes = (int*)malloc(groupsCount * sizeof(int));
    char*** result = (char***)malloc(groupsCount * sizeof(char**));

    for (int i = 0; i < groupsCount; i++) {
        AnagramGroup* group = groups[i];
        (*returnColumnSizes)[i] = group->count;
        result[i] = (char**)malloc(group->count * sizeof(char*));
        for (int j = 0; j < group->count; j++) {
            result[i][j] = group->strings[j]; // Assign the duplicated strings to the result
        }
    }

    // Clean up the temporary AnagramGroup structures
    // The actual strings are now owned by 'result' and will be freed by the LeetCode test harness
    for (int i = 0; i < groupsCount; i++) {
        free(groups[i]->sortedKey); // Free the sorted key
        free(groups[i]->strings);   // Free the array of string pointers (not the strings themselves)
        free(groups[i]);            // Free the AnagramGroup structure
    }
    free(groups); // Free the array of AnagramGroup pointers

    return result;
}