#include <stdlib.h>

int* evenOddBit(int n, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 2);
    *returnSize = 2;

    int even_count = 0;
    int odd_count = 0;
    int position = 0;

    while (n > 0) {
        if ((n & 1) == 1) {
            if (position % 2 == 0) {
                even_count++;
            } else {
                odd_count++;
            }
        }
        n >>= 1;
        position++;
    }

    result[0] = even_count;
    result[1] = odd_count;

    return result;
}