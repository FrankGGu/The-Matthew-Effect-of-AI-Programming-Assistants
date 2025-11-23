#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperations(char * num){
    int n = 0;
    while (num[n] != '\0') {
        n++;
    }
    int ans = n;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int val = (num[i] - '0') * 10 + (num[j] - '0');
            if (val % 25 == 0) {
                ans = fmin(ans, n - i - 2);
            }
        }
    }
    return ans;
}