#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxRepOpt1(char * text){
    int n = strlen(text);
    int count[26] = {0};
    for (int i = 0; i < n; i++) {
        count[text[i] - 'a']++;
    }

    int maxLen = 1;
    for (int i = 0; i < n; i++) {
        int len = 1;
        int j = i + 1;
        while (j < n && text[j] == text[i]) {
            len++;
            j++;
        }

        if (len < count[text[i] - 'a']) {
            int k = j + 1;
            while (k < n && text[k] == text[i]) {
                k++;
            }
            maxLen = (maxLen > len + 1) ? maxLen : (len + 1);
        } else {
            maxLen = (maxLen > len) ? maxLen : len;
        }

        int k = j;
        if (j < n) {
            int tempLen = 1;
            while (k < n && text[k] == text[i]) {
                tempLen++;
                k++;
            }

            if (count[text[i] - 'a'] > len)
                maxLen = (maxLen > len + 1) ? maxLen : (len + 1);
            else
                maxLen = (maxLen > len) ? maxLen : len;

        }
        i = j - 1;
    }

    return maxLen;
}