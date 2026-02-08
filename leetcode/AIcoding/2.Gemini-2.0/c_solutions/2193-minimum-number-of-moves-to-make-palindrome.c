#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minMovesToMakePalindrome(char * s){
    int n = strlen(s);
    int moves = 0;
    for (int i = 0; i < n / 2; i++) {
        int j = n - i - 1;
        while (s[i] != s[j]) {
            j--;
        }
        if (i == j) {
            moves += n / 2 - i;
        } else {
            for (int k = j; k < n - i - 1; k++) {
                char temp = s[k];
                s[k] = s[k + 1];
                s[k + 1] = temp;
                moves++;
            }
        }
    }
    return moves;
}