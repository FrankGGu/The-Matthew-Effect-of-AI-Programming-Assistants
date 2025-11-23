#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minArraySum(int n, int k) {
    return k * (k + 1) / 2 + (n > k ? (n - k) * k : 0);
}