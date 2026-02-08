#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int scoreOfParentheses(char * s){
    int bal = 0;
    int ans = 0;
    for (int i = 0; s[i] != '\0'; ++i) {
        if (s[i] == '(') {
            bal++;
        } else {
            bal--;
            if (s[i-1] == '(') {
                ans += 1 << bal;
            }
        }
    }
    return ans;
}