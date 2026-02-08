#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool hasAllCodes(char * s, int k){
    int len = strlen(s);
    if (len < k) return false;
    int need = pow(2, k);
    bool *seen = (bool*)calloc(need, sizeof(bool));
    int count = 0;
    for (int i = 0; i <= len - k; i++) {
        int num = 0;
        for (int j = 0; j < k; j++) {
            num = num * 2 + (s[i + j] - '0');
        }
        if (!seen[num]) {
            seen[num] = true;
            count++;
        }
    }
    free(seen);
    return count == need;
}