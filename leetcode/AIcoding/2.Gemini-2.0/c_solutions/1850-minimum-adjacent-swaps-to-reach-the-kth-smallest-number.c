#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getKthPermutation(char* num, int k) {
    int n = strlen(num);
    char* original = (char*)malloc((n + 1) * sizeof(char));
    strcpy(original, num);

    int count = 0;
    while (count < k) {
        int i = n - 2;
        while (i >= 0 && num[i] >= num[i + 1]) {
            i--;
        }

        if (i < 0) {
            break;
        }

        int j = n - 1;
        while (num[j] <= num[i]) {
            j--;
        }

        char temp = num[i];
        num[i] = num[j];
        num[j] = temp;

        int left = i + 1;
        int right = n - 1;
        while (left < right) {
            temp = num[left];
            num[left] = num[right];
            num[right] = temp;
            left++;
            right--;
        }
        count++;
    }

    int swaps = 0;
    char* target = num;

    strcpy(num, original);
    for (int i = 0; i < n; i++) {
        if (num[i] != target[i]) {
            for (int j = i + 1; j < n; j++) {
                if (num[j] == target[i]) {
                    for (int k = j; k > i; k--) {
                        char temp = num[k];
                        num[k] = num[k - 1];
                        num[k - 1] = temp;
                        swaps++;
                    }
                    break;
                }
            }
        }
    }

    free(original);
    return swaps;
}

int getMinSwaps(char* num, int k) {
    return getKthPermutation(num, k);
}