#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * reverseOnlyLetters(char * s){
    int left = 0;
    int right = strlen(s) - 1;

    while (left < right) {
        while (left < right && !((s[left] >= 'a' && s[left] <= 'z') || (s[left] >= 'A' && s[left] <= 'Z'))) {
            left++;
        }
        while (left < right && !((s[right] >= 'a' && s[right] <= 'z') || (s[right] >= 'A' && s[right] <= 'Z'))) {
            right--;
        }

        if (left < right) {
            char temp = s[left];
            s[left] = s[right];
            s[right] = temp;
            left++;
            right--;
        }
    }

    return s;
}