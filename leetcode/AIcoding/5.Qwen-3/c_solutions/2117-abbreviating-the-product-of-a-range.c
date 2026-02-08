#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* abbreviateProduct(char* left, char* right) {
    int l = atoi(left);
    int r = atoi(right);
    char* result = (char*)malloc(100 * sizeof(char));
    long long product = 1;
    int count = 0;
    for (int i = l; i <= r; i++) {
        product *= i;
        if (product > 1e12) {
            product /= 10;
            count++;
        }
    }
    char buffer[20];
    sprintf(buffer, "%lld", product);
    int len = strlen(buffer);
    char* suffix = (char*)malloc(5 * sizeof(char));
    strcpy(suffix, "e");
    sprintf(suffix + 1, "%d", count);
    char* prefix = (char*)malloc(5 * sizeof(char));
    strncpy(prefix, buffer, 4);
    prefix[4] = '\0';
    sprintf(result, "%s%s", prefix, suffix);
    return result;
}