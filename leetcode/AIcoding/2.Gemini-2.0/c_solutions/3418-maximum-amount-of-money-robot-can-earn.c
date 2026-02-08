#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxAmount(int amount, int increment) {
    return amount * (amount + 1) / 2 + increment * amount;
}