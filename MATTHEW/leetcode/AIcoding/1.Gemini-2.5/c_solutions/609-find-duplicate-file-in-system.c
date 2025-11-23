#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct {
    char *content;
    char *fullPath;
} FileEntry;

int compareFileEntries(const void *a, const void *b) {
    FileEntry *fa = (FileEntry *)a;
    FileEntry *fb = (FileEntry *)b;
    return strcmp(fa->content, fb->content);
}

void parseFileEntry(const char *entry, char **filename_out, char **content_out) {
    char *open_paren = strchr(entry, '(');
    char *close_paren = strchr(entry, ')');

    // Filename
    int filename_len = open_paren - entry;
    *filename_out = (char *)malloc(filename_len + 1);
    strncpy(*filename_out, entry, filename_len);
    (*filename_out)[filename_len] = '\0';

    // Content
    int content_len = close_paren - (open_paren + 1);
    *content_out = (char *)malloc(content_len + 1);
    strncpy(*content_out, open_paren + 1, content_len);
    (*content_out)[content_len] = '\0';
}

char ***findDuplicate(char **paths, int pathsSize, int *returnSize, int **returnColumnSizes) {
    // Initialize dynamic array for all file entries
    FileEntry *allFiles = NULL;
    int numFiles = 0;
    int capacityFiles = 0;

    // Loop through each path string
    for (int i = 0; i < pathsSize; i++) {
        // Create a mutable copy of the path string for strtok
        char *pathCopy = strdup(paths[i]);
        char *token = strtok(pathCopy, " ");

        char *directory = token; // First token is the directory

        // Loop through remaining tokens (file entries)
        while ((token = strtok(NULL, " ")) != NULL) {
            // Reallocate if capacity is reached
            if (numFiles == capacityFiles) {
                capacityFiles = (capacityFiles == 0) ? 10 : capacityFiles * 2;
                allFiles = (FileEntry *)realloc(allFiles, capacityFiles * sizeof(FileEntry));
            }

            char *filename = NULL;
            char *content = NULL;
            parseFileEntry(token, &filename, &content);

            // Construct full path
            int dirLen = strlen(directory);
            int fileLen = strlen(filename);
            char *fullPath = (char *)malloc(dirLen + 1 + fileLen + 1); // +1 for '/', +1 for null terminator
            strcpy(fullPath, directory);
            strcat(fullPath, "/");
            strcat(fullPath, filename);

            // Store in allFiles array
            allFiles[numFiles].content = content;
            allFiles[numFiles].fullPath = fullPath;
            numFiles++;

            // Free temporary filename, content is stored in allFiles
            free(filename);
        }
        free(pathCopy); // Free the mutable copy
    }

    // Sort all files by content
    qsort(allFiles, numFiles, sizeof(FileEntry), compareFileEntries);

    // Initialize result structures
    char ***result = NULL;
    *returnSize = 0;
    int resultCapacity = 0;
    *returnColumnSizes = NULL;
    int *columnSizes = NULL;

    // Iterate through sorted files to find duplicates
    int i = 0;
    while (i < numFiles) {
        int j = i;
        // Find all files with the same content
        while (j < numFiles && strcmp(allFiles[j].content, allFiles[i].content) == 0) {
            j++;
        }

        // If more than one file has this content, it's a duplicate group
        if (j - i > 1) {
            // Reallocate result and columnSizes if needed
            if (*returnSize == resultCapacity) {
                resultCapacity = (resultCapacity == 0) ? 5 : resultCapacity * 2;
                result = (char ***)realloc(result, resultCapacity * sizeof(char **));
                columnSizes = (int *)realloc(columnSizes, resultCapacity * sizeof(int));
            }

            int groupSize = j - i;
            char **group = (char **)malloc(groupSize * sizeof(char *));
            for (int k = 0; k < groupSize; k++) {
                group[k] = strdup(allFiles[i + k].fullPath); // Duplicate path for return value
            }

            result[*returnSize] = group;
            columnSizes[*returnSize] = groupSize;
            (*returnSize)++;
        }
        i = j; // Move to the next unique content
    }

    *returnColumnSizes = columnSizes;

    // Free all temporary FileEntry structures and their internal strings
    for (int k = 0; k < numFiles; k++) {
        free(allFiles[k].content);
        free(allFiles[k].fullPath);
    }
    free(allFiles);

    return result;
}