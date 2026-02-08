#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximizeAmount(int amount, int conversion1, int conversion2) {
    int ans1 = amount / 2 * conversion1 + amount % 2;
    int ans2 = amount / 3 * conversion2 + amount % 3;
    return (ans1 > ans2) ? ans1 : ans2;
}