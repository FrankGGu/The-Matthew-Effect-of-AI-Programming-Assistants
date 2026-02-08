#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfSubstrings(char* s) {
    int count[3] = {0};
    int left = 0;
    int result = 0;
    for (int right = 0; right < strlen(s); right++) {
        count[s[right] - '0']++;
        while (count[0] > 0 && count[1] > 0) {
            count[s[left] - '0']--;
            left++;
        }
        result += left;
    }
    return result;
}