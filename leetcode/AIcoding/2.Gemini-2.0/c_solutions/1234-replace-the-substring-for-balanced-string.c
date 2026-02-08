#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int balancedString(char * s){
    int n = strlen(s);
    int k = n / 4;
    int count[26] = {0};
    for (int i = 0; i < n; i++) {
        count[s[i] - 'A']++;
    }
    int left = 0, right = 0, ans = n;
    while (right < n) {
        count[s[right] - 'A']--;
        while (left <= right && count['Q' - 'A'] <= k && count['W' - 'A'] <= k && count['E' - 'A'] <= k && count['R' - 'A'] <= k) {
            ans = fmin(ans, right - left + 1);
            count[s[left] - 'A']++;
            left++;
        }
        right++;
    }
    return ans;
}