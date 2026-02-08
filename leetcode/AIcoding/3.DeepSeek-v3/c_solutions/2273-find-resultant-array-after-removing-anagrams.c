/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** removeAnagrams(char** words, int wordsSize, int* returnSize) {
    if (wordsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    char** result = (char**)malloc(wordsSize * sizeof(char*));
    int resultIndex = 0;
    result[resultIndex++] = words[0];

    for (int i = 1; i < wordsSize; i++) {
        char* prev = result[resultIndex - 1];
        char* curr = words[i];

        int prevLen = strlen(prev);
        int currLen = strlen(curr);

        if (prevLen != currLen) {
            result[resultIndex++] = curr;
            continue;
        }

        int count[26] = {0};

        for (int j = 0; j < prevLen; j++) {
            count[prev[j] - 'a']++;
            count[curr[j] - 'a']--;
        }

        int isAnagram = 1;
        for (int j = 0; j < 26; j++) {
            if (count[j] != 0) {
                isAnagram = 0;
                break;
            }
        }

        if (!isAnagram) {
            result[resultIndex++] = curr;
        }
    }

    *returnSize = resultIndex;
    return result;
}