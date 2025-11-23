#include <string.h>
#include <stdbool.h>

bool isStretchy(const char* s, const char* w) {
    int s_len = strlen(s);
    int w_len = strlen(w);

    int i = 0; // Pointer for string s
    int j = 0; // Pointer for word w

    while (i < s_len && j < w_len) {
        // Characters at current pointers must match
        if (s[i] != w[j]) {
            return false;
        }

        char current_char = s[i];

        // Count consecutive occurrences of current_char in s
        int count_s = 0;
        int k_s = i;
        while (k_s < s_len && s[k_s] == current_char) {
            count_s++;
            k_s++;
        }

        // Count consecutive occurrences of current_char in w
        int count_w = 0;
        int k_w = j;
        while (k_w < w_len && w[k_w] == current_char) {
            count_w++;
            k_w++;
        }

        // Apply the rules for expressive words
        // Rule 1: The block in w cannot be longer than the corresponding block in s
        if (count_s < count_w) {
            return false;
        }
        // Rule 2: If the block in s is longer than the block in w,
        // the block in s must have at least 3 characters.
        // If count_s == count_w, this condition is skipped, which is correct.
        if (count_s > count_w && count_s < 3) {
            return false;
        }

        // Advance pointers to the next distinct character block
        i += count_s;
        j += count_w;
    }

    // Both pointers must have reached the end of their respective strings
    return i == s_len && j == w_len;
}

int expressiveWords(char* s, char** words, int wordsSize) {
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        if (isStretchy(s, words[i])) {
            count++;
        }
    }
    return count;
}