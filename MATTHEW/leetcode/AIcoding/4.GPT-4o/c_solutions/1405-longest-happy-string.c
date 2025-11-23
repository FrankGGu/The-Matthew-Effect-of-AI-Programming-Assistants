#include <string.h>
#include <stdlib.h>

char* longestDiverseString(int a, int b, int c) {
    char* result = (char*)malloc(20001 * sizeof(char));
    int index = 0;
    while (a > 0 || b > 0 || c > 0) {
        if ((a >= b && a >= c && (index < 2 || result[index - 1] != 'a' || result[index - 2] != 'a')) || (b == 0 && c == 0)) {
            if (index < 2 || result[index - 1] != 'a' || result[index - 2] != 'a') {
                result[index++] = 'a';
                a--;
            }
        } else if ((b >= a && b >= c && (index < 2 || result[index - 1] != 'b' || result[index - 2] != 'b')) || (a == 0 && c == 0)) {
            if (index < 2 || result[index - 1] != 'b' || result[index - 2] != 'b') {
                result[index++] = 'b';
                b--;
            }
        } else if ((c >= a && c >= b && (index < 2 || result[index - 1] != 'c' || result[index - 2] != 'c')) || (a == 0 && b == 0)) {
            if (index < 2 || result[index - 1] != 'c' || result[index - 2] != 'c') {
                result[index++] = 'c';
                c--;
            }
        } else {
            break;
        }
    }
    result[index] = '\0';
    return result;
}