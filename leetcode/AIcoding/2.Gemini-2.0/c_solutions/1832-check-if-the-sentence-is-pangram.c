#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkIfPangram(char * sentence){
    int seen[26] = {0};
    int count = 0;
    for (int i = 0; sentence[i] != '\0'; i++) {
        if (sentence[i] >= 'a' && sentence[i] <= 'z') {
            int index = sentence[i] - 'a';
            if (seen[index] == 0) {
                seen[index] = 1;
                count++;
            }
        }
    }
    return count == 26;
}