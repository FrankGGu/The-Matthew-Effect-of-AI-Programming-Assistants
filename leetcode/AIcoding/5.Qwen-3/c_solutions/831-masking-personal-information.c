#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* maskPII(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc(100 * sizeof(char));
    if (len == 10) {
        sprintf(result, "***-***-%s", s + 7);
    } else {
        sprintf(result, "***-***-%s", s + 8);
    }
    return result;
}