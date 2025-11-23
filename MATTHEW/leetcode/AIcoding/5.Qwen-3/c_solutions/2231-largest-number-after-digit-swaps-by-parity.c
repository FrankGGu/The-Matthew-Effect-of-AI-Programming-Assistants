#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* largestNumber(char* nums) {
    int n = strlen(nums);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    strcpy(result, nums);

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if ((result[i] % 2 == result[j] % 2) && (result[j] > result[i])) {
                char temp = result[i];
                result[i] = result[j];
                result[j] = temp;
            }
        }
    }

    return result;
}