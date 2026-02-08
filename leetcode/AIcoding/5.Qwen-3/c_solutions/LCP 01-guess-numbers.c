#include <stdio.h>
#include <stdlib.h>

int guess(int num);

int findNumber() {
    int left = 1;
    int right = 1000000;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        int res = guess(mid);
        if (res == 0) {
            return mid;
        } else if (res == -1) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return -1;
}