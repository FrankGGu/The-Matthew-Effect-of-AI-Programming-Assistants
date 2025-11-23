#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int oddEvenJumps(int* arr, int arrSize) {
    bool* odd = (bool*)malloc(arrSize * sizeof(bool));
    bool* even = (bool*)malloc(arrSize * sizeof(bool));
    odd[arrSize - 1] = true;
    even[arrSize - 1] = true;
    int ans = 1;

    for (int i = arrSize - 2; i >= 0; i--) {
        int odd_next = -1;
        int even_next = -1;
        int min_val = 100001;
        int max_val = -1;

        for (int j = i + 1; j < arrSize; j++) {
            if (arr[j] >= arr[i] && arr[j] < min_val) {
                min_val = arr[j];
                odd_next = j;
            }
            if (arr[j] <= arr[i] && arr[j] > max_val) {
                max_val = arr[j];
                even_next = j;
            }
        }

        if (odd_next != -1) {
            odd[i] = even[odd_next];
            if (odd[i]) ans++;
        } else {
            odd[i] = false;
        }

        if (even_next != -1) {
            even[i] = odd[even_next];
        } else {
            even[i] = false;
        }
    }

    free(odd);
    free(even);
    return ans;
}