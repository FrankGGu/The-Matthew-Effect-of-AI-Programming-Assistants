#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProfit(int price[], int n, int fee) {
    int buy = -price[0];
    int sell = 0;
    for (int i = 1; i < n; i++) {
        int temp = buy;
        buy = (buy > sell - price[i]) ? buy : sell - price[i];
        sell = (sell > temp + price[i] - fee) ? sell : temp + price[i] - fee;
    }
    return sell;
}