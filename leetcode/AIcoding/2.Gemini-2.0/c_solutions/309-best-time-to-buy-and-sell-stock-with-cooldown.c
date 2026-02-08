#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxProfit(int* prices, int pricesSize){
    if (pricesSize <= 1) return 0;

    int buy[pricesSize];
    int sell[pricesSize];
    int cooldown[pricesSize];

    buy[0] = -prices[0];
    sell[0] = 0;
    cooldown[0] = 0;

    for (int i = 1; i < pricesSize; i++) {
        buy[i] = (buy[i-1] > cooldown[i-1] - prices[i] ? buy[i-1] : cooldown[i-1] - prices[i]);
        buy[i] = (buy[i] > sell[i-1] - prices[i] ? buy[i] : sell[i-1] - prices[i]);

        sell[i] = (sell[i-1] > buy[i-1] + prices[i] ? sell[i-1] : buy[i-1] + prices[i]);

        cooldown[i] = (cooldown[i-1] > sell[i-1] ? cooldown[i-1] : sell[i-1]);
        cooldown[i] = (cooldown[i] > buy[i-1] ? cooldown[i] : buy[i-1]); 
    }

    return (sell[pricesSize - 1] > cooldown[pricesSize - 1] ? sell[pricesSize - 1] : cooldown[pricesSize - 1]);
}