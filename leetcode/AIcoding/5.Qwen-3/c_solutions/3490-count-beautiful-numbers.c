#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countBeautifulNumbers(char* num) {
    int n = strlen(num);
    int count = 0;
    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= n - i; j++) {
            char sub[10];
            strncpy(sub, num + j, i);
            sub[i] = '\0';
            int freq[10] = {0};
            int unique = 0;
            for (int k = 0; k < i; k++) {
                int digit = sub[k] - '0';
                if (freq[digit] == 0) {
                    unique++;
                }
                freq[digit]++;
            }
            if (unique == i) {
                count++;
            }
        }
    }
    return count;
}