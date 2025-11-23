#include <stdbool.h>

bool arrayStringsAreEqual(char **word1, int word1Size, char **word2, int word2Size) {
    int w1_idx = 0; 
    int c1_idx = 0; 

    int w2_idx = 0; 
    int c2_idx = 0; 

    while (w1_idx < word1Size && w2_idx < word2Size) {
        if (word1[w1_idx][c1_idx] != word2[w2_idx][c2_idx]) {
            return false;
        }

        c1_idx++;
        if (word1[w1_idx][c1_idx] == '\0') { 
            w1_idx++;
            c1_idx = 0;
        }

        c2_idx++;
        if (word2[w2_idx][c2_idx] == '\0') { 
            w2_idx++;
            c2_idx = 0;
        }
    }

    return w1_idx == word1Size && w2_idx == word2Size;
}