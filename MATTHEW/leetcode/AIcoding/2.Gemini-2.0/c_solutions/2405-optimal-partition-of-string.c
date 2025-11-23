#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int partitionString(char * s){
    int count = 1;
    int seen[26] = {0};
    for (int i = 0; s[i] != '\0'; i++) {
        int index = s[i] - 'a';
        if (seen[index] == 1) {
            count++;
            for (int j = 0; j < 26; j++) {
                seen[j] = 0;
            }
        }
        seen[index] = 1;
    }
    return count;
}