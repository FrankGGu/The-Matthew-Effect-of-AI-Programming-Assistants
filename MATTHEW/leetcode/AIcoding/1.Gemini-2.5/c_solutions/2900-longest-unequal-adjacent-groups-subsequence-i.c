#include <stdlib.h>
#include <string.h>

char** longestUnequalAdjacentGroupsSubsequence(int* groups, int groupsSize, char** words, int wordsSize, int* returnSize) {
    if (groupsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    char** result = (char**)malloc(groupsSize * sizeof(char*));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int currentResultCount = 0;

    result[currentResultCount++] = strdup(words[0]);
    int lastAddedGroupId = groups[0];

    for (int i = 1; i < groupsSize; i++) {
        if (groups[i] != lastAddedGroupId) {
            result[currentResultCount++] = strdup(words[i]);
            lastAddedGroupId = groups[i];
        }
    }

    *returnSize = currentResultCount;

    return result;
}