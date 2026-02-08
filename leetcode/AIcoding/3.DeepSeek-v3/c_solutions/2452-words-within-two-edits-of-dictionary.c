/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** twoEditWords(char** queries, int queriesSize, char** dictionary, int dictionarySize, int* returnSize) {
    char** result = (char**)malloc(queriesSize * sizeof(char*));
    int count = 0;

    for (int i = 0; i < queriesSize; i++) {
        char* query = queries[i];
        int len = strlen(query);
        int found = 0;

        for (int j = 0; j < dictionarySize && !found; j++) {
            char* dict = dictionary[j];
            int edits = 0;

            for (int k = 0; k < len && edits <= 2; k++) {
                if (query[k] != dict[k]) {
                    edits++;
                }
            }

            if (edits <= 2) {
                found = 1;
            }
        }

        if (found) {
            result[count] = (char*)malloc((len + 1) * sizeof(char));
            strcpy(result[count], query);
            count++;
        }
    }

    *returnSize = count;
    return result;
}