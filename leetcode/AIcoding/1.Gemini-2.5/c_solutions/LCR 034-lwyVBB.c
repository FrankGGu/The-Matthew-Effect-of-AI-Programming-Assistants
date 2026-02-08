#include <stdbool.h>
#include <string.h>

int char_to_rank[26];

bool isAlienSorted(char ** words, int wordsSize, char * order) {
    for (int i = 0; i < 26; i++) {
        char_to_rank[order[i] - 'a'] = i;
    }

    for (int i = 0; i < wordsSize - 1; i++) {
        char *word1 = words[i];
        char *word2 = words[i+1];

        int len1 = strlen(word1);
        int len2 = strlen(word2);

        int k = 0;
        bool diff_found = false;

        while (k < len1 && k < len2) {
            int rank1 = char_to_rank[word1[k] - 'a'];
            int rank2 = char_to_rank[word2[k] - 'a'];

            if (rank1 < rank2) {
                diff_found = true;
                break;
            } else if (rank1 > rank2) {
                return false;
            }
            k++;
        }

        if (!diff_found) {
            if (len1 > len2) {
                return false;
            }
        }
    }

    return true;
}