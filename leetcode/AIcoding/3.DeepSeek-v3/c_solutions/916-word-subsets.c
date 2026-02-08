/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** wordSubsets(char** words1, int words1Size, char** words2, int words2Size, int* returnSize) {
    int maxCount[26] = {0};

    for (int i = 0; i < words2Size; i++) {
        int tempCount[26] = {0};
        char* word = words2[i];
        for (int j = 0; word[j] != '\0'; j++) {
            tempCount[word[j] - 'a']++;
        }
        for (int j = 0; j < 26; j++) {
            if (tempCount[j] > maxCount[j]) {
                maxCount[j] = tempCount[j];
            }
        }
    }

    char** result = (char**)malloc(words1Size * sizeof(char*));
    int count = 0;

    for (int i = 0; i < words1Size; i++) {
        int wordCount[26] = {0};
        char* word = words1[i];
        for (int j = 0; word[j] != '\0'; j++) {
            wordCount[word[j] - 'a']++;
        }

        int valid = 1;
        for (int j = 0; j < 26; j++) {
            if (wordCount[j] < maxCount[j]) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            result[count] = (char*)malloc((strlen(word) + 1) * sizeof(char));
            strcpy(result[count], word);
            count++;
        }
    }

    *returnSize = count;
    return result;
}