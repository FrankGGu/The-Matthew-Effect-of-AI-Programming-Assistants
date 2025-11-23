#include <stdbool.h>

int longestPalindrome(char ** words, int wordsSize) {
    int counts[26][26] = {0};

    for (int i = 0; i < wordsSize; i++) {
        counts[words[i][0] - 'a'][words[i][1] - 'a']++;
    }

    int ans = 0;
    bool has_odd_center = false;

    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 26; j++) {
            if (i == j) {
                int count = counts[i][j];
                ans += (count / 2) * 4;
                if (count % 2 == 1) {
                    has_odd_center = true;
                }
            } else {
                if (j > i) {
                    int count1 = counts[i][j];
                    int count2 = counts[j][i];

                    int pairs = (count1 < count2 ? count1 : count2); 
                    ans += pairs * 4;
                }
            }
        }
    }

    if (has_odd_center) {
        ans += 2;
    }

    return ans;
}