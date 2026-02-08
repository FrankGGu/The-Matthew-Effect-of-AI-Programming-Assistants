#include <string.h>
#include <limits.h>

int beautySum(char * s){
    int n = strlen(s);
    int totalBeauty = 0;

    for (int i = 0; i < n; i++) {
        int freq[26] = {0}; 
        for (int j = i; j < n; j++) {
            freq[s[j] - 'a']++;

            int maxFreq = 0;
            int minFreq = INT_MAX;

            for (int k = 0; k < 26; k++) {
                if (freq[k] > 0) {
                    if (freq[k] > maxFreq) {
                        maxFreq = freq[k];
                    }
                    if (freq[k] < minFreq) {
                        minFreq = freq[k];
                    }
                }
            }
            totalBeauty += (maxFreq - minFreq);
        }
    }
    return totalBeauty;
}