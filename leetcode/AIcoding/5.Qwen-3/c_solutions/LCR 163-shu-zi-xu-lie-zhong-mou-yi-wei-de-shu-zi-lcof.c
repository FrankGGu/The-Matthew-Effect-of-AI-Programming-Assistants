#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int findKthNumber(int n, int k) {
    long long number = 1;
    long long count = 0;
    while (count < k) {
        long long steps = 0;
        long long curr = number;
        long long next = number + 1;
        while (curr <= n) {
            steps += (next - curr);
            curr *= 10;
            next *= 10;
        }
        if (count + steps < k) {
            count += steps;
            number++;
        } else {
            count++;
            number *= 10;
        }
    }
    return number;
}