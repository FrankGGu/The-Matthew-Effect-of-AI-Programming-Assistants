#include <stdio.h>
#include <stdlib.h>

int maxAlternatingSum(int* prices, int pricesSize) {
    int even = 0, odd = 0;
    for (int i = 0; i < pricesSize; i++) {
        int temp = even;
        even = (even > odd + prices[i]) ? even : odd + prices[i];
        odd = (odd > temp - prices[i]) ? odd : temp - prices[i];
    }
    return even;
}