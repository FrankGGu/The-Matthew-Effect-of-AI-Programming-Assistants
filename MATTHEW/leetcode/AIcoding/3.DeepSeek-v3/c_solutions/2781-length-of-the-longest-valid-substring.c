typedef struct {
    char* word;
    int len;
} Word;

int longestValidSubstring(char* word, char** forbidden, int forbiddenSize) {
    Word* forb = (Word*)malloc(forbiddenSize * sizeof(Word));
    for (int i = 0; i < forbiddenSize; i++) {
        forb[i].word = forbidden[i];
        forb[i].len = strlen(forbidden[i]);
    }

    int n = strlen(word);
    int right = n;
    int max_len = 0;

    for (int left = n - 1; left >= 0; left--) {
        for (int i = 0; i < forbiddenSize; i++) {
            int len = forb[i].len;
            if (left + len > right) continue;
            if (strncmp(word + left, forb[i].word, len) == 0) {
                right = left + len - 1;
                break;
            }
        }
        if (right - left > max_len) {
            max_len = right - left;
        }
    }

    free(forb);
    return max_len;
}