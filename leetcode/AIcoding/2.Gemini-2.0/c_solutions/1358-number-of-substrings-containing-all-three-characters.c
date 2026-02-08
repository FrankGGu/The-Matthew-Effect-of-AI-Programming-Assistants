#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfSubstrings(char * s){
    int count[3] = {0, 0, 0};
    int left = 0, right = 0;
    int ans = 0;
    while (right < strlen(s)) {
        count[s[right] - 'a']++;
        while (count[0] > 0 && count[1] > 0 && count[2] > 0) {
            ans += strlen(s) - right;
            count[s[left] - 'a']--;
            left++;
        }
        right++;
    }
    return ans;
}