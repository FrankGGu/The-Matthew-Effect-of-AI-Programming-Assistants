#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

typedef struct {
    int price;
    int quantity;
} Order;

int compareBuy(const void *a, const void *b) {
    return ((Order *)b)->price - ((Order *)a)->price;
}

int compareSell(const void *a, const void *b) {
    return ((Order *)a)->price - ((Order *)b)->price;
}

int getNumberOfBacklogOrders(int **orders, int ordersSize, int *ordersColSize) {
    Order *buyOrders = (Order *)malloc(ordersSize * sizeof(Order));
    Order *sellOrders = (Order *)malloc(ordersSize * sizeof(Order));
    int buyCount = 0;
    int sellCount = 0;

    for (int i = 0; i < ordersSize; i++) {
        int price = orders[i][0];
        int quantity = orders[i][1];
        int orderType = orders[i][2];

        if (orderType == 0) { // Buy order
            while (sellCount > 0 && sellOrders[0].price <= price && quantity > 0) {
                if (sellOrders[0].quantity <= quantity) {
                    quantity -= sellOrders[0].quantity;

                    for(int j = 0; j < sellCount - 1; j++){
                        sellOrders[j] = sellOrders[j+1];
                    }
                    sellCount--;

                } else {
                    sellOrders[0].quantity -= quantity;
                    quantity = 0;
                }
                qsort(sellOrders, sellCount, sizeof(Order), compareSell);
            }

            if (quantity > 0) {
                buyOrders[buyCount].price = price;
                buyOrders[buyCount].quantity = quantity;
                buyCount++;
                qsort(buyOrders, buyCount, sizeof(Order), compareBuy);
            }
        } else { // Sell order
            while (buyCount > 0 && buyOrders[0].price >= price && quantity > 0) {
                if (buyOrders[0].quantity <= quantity) {
                    quantity -= buyOrders[0].quantity;
                    for(int j = 0; j < buyCount - 1; j++){
                        buyOrders[j] = buyOrders[j+1];
                    }
                    buyCount--;

                } else {
                    buyOrders[0].quantity -= quantity;
                    quantity = 0;
                }
                qsort(buyOrders, buyCount, sizeof(Order), compareBuy);
            }

            if (quantity > 0) {
                sellOrders[sellCount].price = price;
                sellOrders[sellCount].quantity = quantity;
                sellCount++;
                qsort(sellOrders, sellCount, sizeof(Order), compareSell);
            }
        }
    }

    long long totalOrders = 0;
    for (int i = 0; i < buyCount; i++) {
        totalOrders = (totalOrders + buyOrders[i].quantity) % MOD;
    }
    for (int i = 0; i < sellCount; i++) {
        totalOrders = (totalOrders + sellOrders[i].quantity) % MOD;
    }

    free(buyOrders);
    free(sellOrders);

    return (int)totalOrders;
}