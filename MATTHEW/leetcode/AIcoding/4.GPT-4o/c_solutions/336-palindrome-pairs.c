typedef struct {
    int index;
    char* word;
} Word;

int is_palindrome(char* word, int start, int end) {
    while (start < end) {
        if (word[start] != word[end]) return 0;
        start++;
        end--;
    }
    return 1;
}

int** palindromePairs(char** words, int wordsSize, int* returnSize, int** returnColumnSizes) {
    int** result = malloc(sizeof(int*) * 128);
    *returnSize = 0;
    *returnColumnSizes = malloc(sizeof(int) * 128);

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 0; j < wordsSize; j++) {
            if (i != j) {
                int len1 = strlen(words[i]);
                int len2 = strlen(words[j]);
                if (is_palindrome(words[i], 0, len1 - 1)) {
                    if (is_palindrome(words[j], 0, len2 - 1)) {
                        result[*returnSize] = malloc(sizeof(int) * 2);
                        result[*returnSize][0] = i;
                        result[*returnSize][1] = j;
                        (*returnColumnSizes)[*returnSize] = 2;
                        (*returnSize)++;
                    }
                }
            }
        }
    }

    return result;
}