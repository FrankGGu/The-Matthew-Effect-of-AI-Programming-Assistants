#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * capitalizeTitle(char * title) {
    int len = strlen(title);
    int start = 0;
    for (int i = 0; i <= len; i++) {
        if (title[i] == ' ' || title[i] == '\0') {
            int wordLen = i - start;
            if (wordLen > 2) {
                title[start] = toupper(title[start]);
                for (int j = start + 1; j < i; j++) {
                    title[j] = tolower(title[j]);
                }
            } else {
                for (int j = start; j < i; j++) {
                    title[j] = tolower(title[j]);
                }
            }
            start = i + 1;
        }
    }
    return title;
}