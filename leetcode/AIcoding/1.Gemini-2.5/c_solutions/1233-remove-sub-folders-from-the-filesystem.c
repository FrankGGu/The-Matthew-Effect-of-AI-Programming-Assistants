#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int compareStrings(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

char** removeSubfolders(char** folders, int foldersSize, int* returnSize) {
    // Handle the edge case where the input array is empty.
    if (foldersSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    // Sort the folders lexicographically.
    // This is crucial because it ensures that a parent folder (e.g., "/a")
    // always appears before its sub-folders (e.g., "/a/b", "/a/b/c").
    qsort(folders, foldersSize, sizeof(char*), compareStrings);

    // Allocate memory for the result array.
    // In the worst case, all folders might be root folders, so we allocate
    // space for all of them initially.
    char** result = (char**)malloc(foldersSize * sizeof(char*));
    // Handle potential memory allocation failure.
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    *returnSize = 0; // Initialize the count of root folders found.

    // Iterate through the sorted folders.
    for (int i = 0; i < foldersSize; ++i) {
        char* currentFolder = folders[i];

        // If the result list is empty, the first folder encountered is always a root folder.
        if (*returnSize == 0) {
            result[*returnSize] = currentFolder;
            (*returnSize)++;
        } else {
            // Get the last added root folder to compare against.
            char* lastRootFolder = result[*returnSize - 1];
            int lenLast = strlen(lastRootFolder);
            int lenCurrent = strlen(currentFolder);

            bool isSubOrIdentical = false;

            // Check if currentFolder starts with lastRootFolder.
            // If it does, it could be a sub-folder or an identical folder.
            if (lenCurrent >= lenLast && strncmp(lastRootFolder, currentFolder, lenLast) == 0) {
                // If lengths are equal, they are identical folders (e.g., "/a" and "/a").
                // If currentFolder is longer and the character immediately after lastRootFolder
                // in currentFolder is a '/', then it's a direct sub-folder (e.g., "/a/b" is a sub-folder of "/a").
                if (lenCurrent == lenLast || currentFolder[lenLast] == '/') {
                    isSubOrIdentical = true;
                }
            }

            // If currentFolder is NOT a sub-folder of the last added root folder
            // AND NOT identical to the last added root folder, then it's a new root folder.
            if (!isSubOrIdentical) {
                result[*returnSize] = currentFolder;
                (*returnSize)++;
            }
        }
    }

    // The `result` array might have more allocated space than `*returnSize`.
    // This is generally acceptable in LeetCode for `char**` return types.
    // The unused pointers at the end of the allocated array are not accessed.

    return result;
}