#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countVowelSubstrings(char* s) {
    int count = 0;
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
            int a = 0, e = 0, i_ = 0, o = 0, u = 0;
            for (int j = i; j < n; j++) {
                char c = s[j];
                if (c == 'a') a++;
                else if (c == 'e') e++;
                else if (c == 'i') i_++;
                else if (c == 'o') o++;
                else if (c == 'u') u++;
                if (a > 0 && e > 0 && i_ > 0 && o > 0 && u > 0) {
                    count++;
                }
            }
        }
    }
    return count;
}