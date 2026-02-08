#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int beautySum(char * s){
    int n = strlen(s);
    int ans = 0;
    for (int i = 0; i < n; i++) {
        int freq[26] = {0};
        for (int j = i; j < n; j++) {
            freq[s[j] - 'a']++;
            int max_freq = 0;
            int min_freq = n;
            for (int k = 0; k < 26; k++) {
                if (freq[k] > 0) {
                    max_freq = (freq[k] > max_freq) ? freq[k] : max_freq;
                    min_freq = (freq[k] < min_freq) ? freq[k] : min_freq;
                }
            }
            ans += max_freq - min_freq;
        }
    }
    return ans;
}