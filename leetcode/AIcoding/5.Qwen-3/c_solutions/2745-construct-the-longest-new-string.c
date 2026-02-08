#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestString(int a, int b, int c, int d) {
    int count[26] = {0};
    count['a' - 'a'] = a;
    count['b' - 'a'] = b;
    count['c' - 'a'] = c;
    count['d' - 'a'] = d;

    char last = '\0';
    int result = 0;

    while (1) {
        int found = 0;
        for (char c = 'a'; c <= 'd'; c++) {
            if (count[c - 'a'] > 0 && c != last) {
                count[c - 'a']--;
                last = c;
                result++;
                found = 1;
                break;
            }
        }
        if (!found) break;
    }

    return result;
}