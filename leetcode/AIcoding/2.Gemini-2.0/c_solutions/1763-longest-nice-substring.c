#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * longestNiceSubstring(char * s){
    int n = strlen(s);
    if (n < 2) {
        return "";
    }

    int start = 0, maxLen = 0;

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            bool nice = true;
            int lower = 0, upper = 0;
            for(int k = i; k <= j; k++){
                if(s[k] >= 'a' && s[k] <= 'z'){
                    lower |= (1 << (s[k] - 'a'));
                } else {
                    upper |= (1 << (s[k] - 'A'));
                }
            }

            if((lower ^ upper) != 0){
                nice = false;
            }

            if (nice && (j - i + 1) > maxLen) {
                maxLen = j - i + 1;
                start = i;
            }
        }
    }

    if (maxLen == 0) {
        return "";
    }

    char *result = (char *)malloc(sizeof(char) * (maxLen + 1));
    strncpy(result, s + start, maxLen);
    result[maxLen] = '\0';

    return result;
}