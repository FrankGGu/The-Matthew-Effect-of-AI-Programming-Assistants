#include <string.h>
#include <stdlib.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int minExtraChar(char * s, char ** dictionary, int dictionarySize){
    int n = strlen(s);

    int dp[n + 1]; 

    dp[n] = 0; 

    for (int i = n - 1; i >= 0; i--) {
        dp[i] = dp[i+1] + 1;

        for (int j = 0; j < dictionarySize; j++) {
            char *word = dictionary[j];
            int word_len = strlen(word);

            if (i + word_len <= n) {
                if (strncmp(&s[i], word, word_len) == 0) {
                    dp[i] = min(dp[i], dp[i + word_len]);
                }
            }
        }
    }

    return dp[0];
}