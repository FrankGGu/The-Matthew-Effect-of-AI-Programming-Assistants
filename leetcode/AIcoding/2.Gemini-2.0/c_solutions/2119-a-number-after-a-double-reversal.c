#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isSameAfterReversals(int num){
    if (num == 0) return true;
    return (num % 10 != 0);
}