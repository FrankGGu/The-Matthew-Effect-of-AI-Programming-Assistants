#include <string.h>

int numberOfSubstrings(char * s){
    long long ans = 0;
    int left = 0;
    int counts[3] = {0}; // counts[0] for 'a', counts[1] for 'b', counts[2] for 'c'
    int n = strlen(s);

    for (int right = 0; right < n; right++) {
        counts[s[right] - 'a']++;

        while (counts[0] > 0 && counts[1] > 0 && counts[2] > 0) {
            // The current window s[left...right] contains all three characters.
            // Any substring starting from 'left' and ending at 'right' or after 'right'
            // (up to n-1) will also contain all three characters.
            // The number of such substrings is (n - 1) - right + 1 = n - right.
            ans += (n - right);

            // Try to shrink the window from the left
            counts[s[left] - 'a']--;
            left++;
        }
    }

    return (int)ans;
}