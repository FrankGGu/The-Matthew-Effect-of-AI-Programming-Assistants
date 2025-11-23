#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long coloredCells(int n){
    return (long long)n * n + (long long)(n - 1) * (n - 1);
}