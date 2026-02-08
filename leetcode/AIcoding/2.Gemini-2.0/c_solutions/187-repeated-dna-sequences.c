#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** findRepeatedDnaSequences(char * s, int returnSize){
    int len = strlen(s);
    if (len < 10) {
        *returnSize = 0;
        return NULL;
    }

    int hash[1 << 20] = {0};
    char **result = (char **)malloc(sizeof(char *) * (len - 9));
    *returnSize = 0;

    int val = 0;
    for (int i = 0; i < 10; i++) {
        val <<= 2;
        switch (s[i]) {
            case 'A': break;
            case 'C': val |= 1; break;
            case 'G': val |= 2; break;
            case 'T': val |= 3; break;
        }
    }
    hash[val] = 1;

    for (int i = 10; i < len; i++) {
        val <<= 2;
        val &= ((1 << 20) - 1);
        switch (s[i]) {
            case 'A': break;
            case 'C': val |= 1; break;
            case 'G': val |= 2; break;
            case 'T': val |= 3; break;
        }
        if (hash[val] == 1) {
            result[*returnSize] = (char *)malloc(sizeof(char) * 11);
            strncpy(result[*returnSize], s + i - 9, 10);
            result[*returnSize][10] = '\0';
            (*returnSize)++;
            hash[val] = 2;
        } else {
            hash[val]++;
        }
    }
    return result;
}