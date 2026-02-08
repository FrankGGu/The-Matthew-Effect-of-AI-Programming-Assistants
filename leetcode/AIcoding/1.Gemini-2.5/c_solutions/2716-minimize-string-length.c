#include <string.h>
#include <stdbool.h>

int minimizeStringLength(char * s){
    bool seen[256] = {false};
    int uniqueCount = 0;
    int i = 0;

    while (s[i] != '\0') {
        if (!seen[(unsigned char)s[i]]) {
            seen[(unsigned char)s[i]] = true;
            uniqueCount++;
        }
        i++;
    }

    return uniqueCount;
}