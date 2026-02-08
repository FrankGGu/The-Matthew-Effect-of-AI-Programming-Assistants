#include <stdio.h>
#include <stdlib.h>

int minimumPerimeter(long long needed) {
    long long n = 1;
    while (n * n * 2 < needed) {
        n++;
    }
    return (int)(n * 8);
}