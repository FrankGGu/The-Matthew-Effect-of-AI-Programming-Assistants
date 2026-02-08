#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSwaps(char * s){
    int open = 0, close = 0;
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] == '[') {
            open++;
        } else {
            close++;
        }
    }
    int imbalance = 0, ans = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '[') {
            imbalance++;
        } else {
            imbalance--;
        }
        if (imbalance < 0) {
            ans++;
            imbalance = 0;
        }
    }
    return ans;
}