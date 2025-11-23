#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countOdd(int low, int high){
    return (high + 1) / 2 - low / 2;
}