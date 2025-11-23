#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char kthCharacter(int n, int k) {
    int length = 1;
    int current = 0;
    while (length < k) {
        length *= 2;
        current++;
    }
    char result = 'a' + current;
    return result;
}