#include <stdbool.h>
#include <string.h>
#include <ctype.h>

bool isVowel(char c) {
    char lower_c = tolower(c);
    return lower_c == 'a' || lower_c == 'e' || lower_c == 'i' || lower_c == 'o' || lower_c == 'u';
}

bool halvesAreAlike(char * s) {
    int n = strlen(s);
    int mid = n / 2;

    int count1 = 0;
    int count2 = 0;

    for (int i = 0; i < mid; i++) {
        if (isVowel(s[i])) {
            count1++;
        }
    }

    for (int i = mid; i < n; i++) {
        if (isVowel(s[i])) {
            count2++;
        }
    }

    return count1 == count2;
}