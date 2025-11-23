#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumBoxes(int n){
    int k = 0;
    while (k * (k + 1) * (k + 2) / 6 < n) {
        k++;
    }
    k--;
    int remaining = n - k * (k + 1) * (k + 2) / 6;
    int l = 0;
    while (l * (l + 1) / 2 < remaining) {
        l++;
    }
    l--;
    return k * (k + 1) / 2 + (remaining > 0 ? (remaining > l*(l+1)/2? l+1 : l+1) : 0);
}