#include <stdbool.h> // For bool type

int longestPalindrome(char **words, int wordsSize) {
    int count[26][26] = {0}; 

    for (int k = 0; k < wordsSize; k++) {
        char *word = words[k];
        int r = word[0] - 'a';
        int c = word[1] - 'a';
        count[r][c]++;
    }

    int total_length = 0;
    bool has_center_word = false;

    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            if (i < j) {
                int num_pairs = (count[i][j] < count[j][i]) ? count[i][j] : count[j][i];
                total_length += 4 * num_pairs;
            } else if (i == j) {
                total_length += 4 * (count[i][j] / 2);

                if (count[i][j] % 2 == 1) {
                    has_center_word = true;
                }
            }
        }
    }

    if (has_center_word) {
        total_length += 2;
    }

    return total_length;
}