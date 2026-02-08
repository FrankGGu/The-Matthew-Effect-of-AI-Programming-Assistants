#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int addMinimum(char * word){
    int count = 0;
    int i = 0;
    int len = 0;
    while(word[len] != '\0'){
        len++;
    }

    while (i < len) {
        if (word[i] == 'a') {
            if (i + 1 < len && word[i + 1] == 'b') {
                if (i + 2 < len && word[i + 2] == 'c') {
                    i += 3;
                } else {
                    count++;
                    i += 2;
                }
            } else {
                if (i + 1 < len && word[i + 1] == 'c'){
                    count++;
                    i += 2;
                }
                else
                {
                    count += 2;
                    i++;
                }

            }
        } else if (word[i] == 'b') {
            if (i + 1 < len && word[i + 1] == 'c') {
                count++;
                i += 2;
            } else {
                count += 2;
                i++;
            }
        } else {
            count += 2;
            i++;
        }
    }

    return count;
}