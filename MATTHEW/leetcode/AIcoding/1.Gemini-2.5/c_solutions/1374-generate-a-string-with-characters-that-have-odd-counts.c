#include <stdlib.h>
#include <string.h>

char * generateTheString(int n){
    char* result = (char*)malloc(sizeof(char) * (n + 1));
    if (n % 2 == 1) {
        memset(result, 'a', n);
    } else {
        memset(result, 'a', n - 1);
        result[n - 1] = 'b';
    }
    result[n] = '\0';
    return result;
}