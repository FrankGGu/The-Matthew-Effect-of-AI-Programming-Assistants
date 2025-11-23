#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int kItemsWithMaximumSum(int numOnes, int numZeros, int numNegOnes, int k) {
    int sum = 0;
    if (k <= numOnes) {
        sum = k;
    } else {
        sum += numOnes;
        k -= numOnes;
        if (k <= numZeros) {
            //sum += 0;
            k = 0;
        } else {
            k -= numZeros;
            sum -= k;
        }
    }
    return sum;
}