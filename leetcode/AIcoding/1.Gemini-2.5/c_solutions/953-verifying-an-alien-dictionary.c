#include <stdbool.h>
#include <string.h>

bool isAlienSorted(char **words, int wordsSize, char *order) {
    int char_rank[26];
    for (int i = 0; i < 26; i++) {
        char_rank[order[i] - 'a'] = i;
    }

    for (int i = 0; i < wordsSize - 1; i++) {
        char *word1 = words[i];
        char *word2 = words[i+1];

        int len1 = strlen(word1);
        int len2 = strlen(word2);

        bool found_difference = false;
        for (int j = 0; j < len1 && j < len2; j++) {
            int rank1 = char_rank[word1[j] - 'a'];
            int rank2 = char_rank[word2[j] - 'a'];

            if (rank1 > rank2) {
                return false;
            }
            if (rank1 < rank2) {
                found_difference = true;
                break;
            }
        }

        if (!found_difference && len1 > len2) {
            return false;
        }
    }

    return true;
}