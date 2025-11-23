#include <string.h>

int countSubstrings(char * s, int k) {
    int n = strlen(s);
    if (n == 0 || k <= 0) {
        return 0;
    }

    int freq[26] = {0};
    int distinct_count = 0;
    int left = 0;
    long long total_count = 0;

    for (int right = 0; right < n; right++) {
        if (freq[s[right] - 'a'] == 0) {
            distinct_count++;
        }
        freq[s[right] - 'a']++;

        while (distinct_count > k) {
            freq[s[left] - 'a']--;
            if (freq[s[left] - 'a'] == 0) {
                distinct_count--;
            }
            left++;
        }
        total_count += (right - left + 1);
    }

    return (int)total_count;
}