#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumSum(int n, int k) {
    int sum = 0;
    int count = 0;
    int num = 1;
    int seen[201] = {0};

    while (count < n) {
        if (seen[num] == 0) {
            sum += num;
            seen[num] = 1;
            seen[k - num] = 1;
            count++;
        }
        num++;
    }

    return sum;
}