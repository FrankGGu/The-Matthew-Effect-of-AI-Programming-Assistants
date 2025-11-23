#include <string.h>
#include <stdbool.h>

int countPrefixes(char **words, int wordsSize, char *s) {
    int count = 0;
    int s_len = strlen(s);

    for (int i = 0; i < wordsSize; i++) {
        char *word = words[i];
        int word_len = strlen(word);

        if (word_len <= s_len) {
            bool is_prefix = true;
            for (int j = 0; j < word_len; j++) {
                if (word[j] != s[j]) {
                    is_prefix = false;
                    break;
                }
            }
            if (is_prefix) {
                count++;
            }
        }
    }
    return count;
}