#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numDifferentIntegers(char * word) {
    int len = strlen(word);
    char *nums[100] = {NULL};
    int numCount = 0;
    int i = 0;
    while (i < len) {
        if (isdigit(word[i])) {
            int start = i;
            while (i < len && isdigit(word[i])) {
                i++;
            }
            int end = i;
            char *num = (char *)malloc(end - start + 1);
            strncpy(num, word + start, end - start);
            num[end - start] = '\0';

            int j = 0;
            while (num[j] == '0' && num[j+1] != '\0') {
                j++;
            }
            char *trimmedNum;
            if (j > 0) {
                 trimmedNum = (char *)malloc(strlen(num) - j + 1);
                strcpy(trimmedNum, num+j);
                free(num);
                num = trimmedNum;
            }

            int found = 0;
            for (int k = 0; k < numCount; k++) {
                if (strcmp(nums[k], num) == 0) {
                    found = 1;
                    break;
                }
            }
            if (!found) {
                nums[numCount] = num;
                numCount++;
            } else {
                free(num);
            }
        } else {
            i++;
        }
    }

    for (int i = 0; i < numCount; i++) {

    }

    return numCount;
}