#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** findRestaurant(char ** list1, int list1Size, char ** list2, int list2Size, int* returnSize){
    int min_sum = 2001;
    int count = 0;
    char **result = (char **)malloc(sizeof(char *) * (list1Size + list2Size));

    for (int i = 0; i < list1Size; i++) {
        for (int j = 0; j < list2Size; j++) {
            if (strcmp(list1[i], list2[j]) == 0) {
                if (i + j < min_sum) {
                    min_sum = i + j;
                    count = 0;
                    result[count] = list1[i];
                    count++;
                } else if (i + j == min_sum) {
                    result[count] = list1[i];
                    count++;
                }
            }
        }
    }

    char **final_result = (char **)malloc(sizeof(char *) * count);
    for (int i = 0; i < count; i++) {
        final_result[i] = (char *)malloc(strlen(result[i]) + 1);
        strcpy(final_result[i], result[i]);
    }

    *returnSize = count;
    free(result);
    return final_result;
}