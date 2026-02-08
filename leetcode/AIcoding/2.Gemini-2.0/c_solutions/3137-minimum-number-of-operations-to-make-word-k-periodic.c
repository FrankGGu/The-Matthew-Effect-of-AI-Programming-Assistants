#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(char * word, int k){
    int n = strlen(word);
    if (n % k != 0) {
        return -1;
    }
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (word[i] != word[i % k]) {
            count++;
        }
    }
    return count / k;
}