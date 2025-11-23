#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canMakeSubsequence(char * str1, char * str2){
    int n = strlen(str1);
    int m = strlen(str2);
    int i = 0, j = 0;
    while (i < n && j < m) {
        if (str1[i] == str2[j] || (str1[i] - 'a' + 1) % 26 == (str2[j] - 'a')) {
            j++;
        }
        i++;
    }
    return j == m;
}