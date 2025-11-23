#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

int rayBouncing(int n, int m) {
    int gcd = __gcd(n, m);
    return (n / gcd + m / gcd - 2) * 2 + 1;
}