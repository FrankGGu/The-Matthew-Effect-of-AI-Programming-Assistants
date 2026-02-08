#define MAX_WORD_LEN 100

bool isSimilar(char* word1, char* word2) {
    int len1 = strlen(word1);
    int len2 = strlen(word2);
    if (abs(len1 - len2) > 2) return false;

    int edits = 0;
    for (int i = 0, j = 0; i < len1 && j < len2; ) {
        if (word1[i] == word2[j]) {
            i++;
            j++;
        } else {
            edits++;
            if (edits > 2) return false;
            if (len1 > len2) {
                i++;
            } else if (len1 < len2) {
                j++;
            } else {
                i++;
                j++;
            }
        }
    }
    return edits <= 2;
}

char** wordsWithinTwoEdits(char** dictionary, int dictSize, char* target, int* returnSize) {
    char** result = (char**)malloc(dictSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < dictSize; i++) {
        if (isSimilar(dictionary[i], target)) {
            result[*returnSize] = dictionary[i];
            (*returnSize)++;
        }
    }

    return result;
}