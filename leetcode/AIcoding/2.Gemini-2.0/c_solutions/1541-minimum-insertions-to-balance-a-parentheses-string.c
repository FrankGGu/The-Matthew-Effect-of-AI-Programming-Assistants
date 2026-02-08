#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minInsertions(char * s){
    int open = 0, ans = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            open++;
        } else {
            if (open > 0) {
                open--;
            } else {
                ans++;
            }
            if (s[i+1] == ')') {
                i++;
            } else {
                ans++;
            }
        }
    }
    ans += 2 * open;
    return ans;
}