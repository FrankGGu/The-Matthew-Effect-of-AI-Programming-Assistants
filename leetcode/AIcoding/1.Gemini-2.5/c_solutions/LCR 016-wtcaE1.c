#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int lengthOfLongestSubstring(char * s){
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    int char_counts[128] = {0}; 
    int left = 0;
    int max_len = 0;

    for (int right = 0; right < n; right++) {
        char_counts[s[right]]++;

        while (char_counts[s[right]] > 1) {
            char_counts[s[left]]--;
            left++;
        }

        max_len = max(max_len, right - left + 1);
    }

    return max_len;
}