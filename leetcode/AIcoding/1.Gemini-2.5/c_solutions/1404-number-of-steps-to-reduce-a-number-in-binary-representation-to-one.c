#include <string.h>
#include <stdlib.h>

int numSteps(char * s) {
    char arr[502];
    strcpy(arr, s);
    int arr_len = strlen(arr);
    int steps = 0;

    while (arr_len > 1) {
        steps++;
        if (arr[arr_len - 1] == '0') {
            arr_len--;
        } else {
            int i = arr_len - 1;
            while (i >= 0 && arr[i] == '1') {
                arr[i] = '0';
                i--;
            }

            if (i < 0) {
                arr_len++;
                arr[0] = '1';
            } else {
                arr[i] = '1';
            }
        }
    }
    return steps;
}