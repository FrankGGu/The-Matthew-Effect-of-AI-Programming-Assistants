#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long flowerGame(int n, int m){
    long long odd_n = (long long)(n + 1) / 2;
    long long even_n = (long long)n / 2;
    long long odd_m = (long long)(m + 1) / 2;
    long long even_m = (long long)m / 2;

    return odd_n * even_m + even_n * odd_m;
}