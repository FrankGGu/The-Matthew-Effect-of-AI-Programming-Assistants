#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int removeAlmostEqualCharacters(char * word){
    int count = 0;
    int i = 0;
    while (word[i] != '\0') {
        if (word[i + 1] != '\0' && abs(word[i] - word[i + 1]) <= 1) {
            count++;
            i += 2;
        } else {
            i++;
        }
    }
    return count;
}