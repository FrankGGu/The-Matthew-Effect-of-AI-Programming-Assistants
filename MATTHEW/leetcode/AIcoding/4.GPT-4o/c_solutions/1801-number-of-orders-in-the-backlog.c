#include <stdio.h>
#include <stdlib.h>

struct Order {
    int price;
    int amount;
    int type; // 0 for buy, 1 for sell
};

int cmp(const void* a, const void* b) {
    struct Order* orderA = (struct Order*)a;
    struct Order* orderB = (struct Order*)b;
    if (orderA->type == orderB->type) {
        if (orderA->type == 0) {
            return orderB->price - orderA->price; // Sort buy orders by price descending
        } else {
            return orderA->price - orderB->price; // Sort sell orders by price ascending
        }
    }
    return orderA->type - orderB->type;
}

int getNumberOfBacklogOrders(int** orders, int ordersSize, int* ordersColSize) {
    struct Order* buyOrders = malloc(ordersSize * sizeof(struct Order));
    struct Order* sellOrders = malloc(ordersSize * sizeof(struct Order));
    int buyCount = 0, sellCount = 0;

    for (int i = 0; i < ordersSize; i++) {
        if (orders[i][2] == 0) {
            buyOrders[buyCount++] = (struct Order){orders[i][0], orders[i][1], 0};
        } else {
            sellOrders[sellCount++] = (struct Order){orders[i][0], orders[i][1], 1};
        }
    }

    qsort(buyOrders, buyCount, sizeof(struct Order), cmp);
    qsort(sellOrders, sellCount, sizeof(struct Order), cmp);

    long long backlog = 0;
    int i = 0, j = 0;

    while (i < buyCount && j < sellCount) {
        if (buyOrders[i].price >= sellOrders[j].price) {
            int amount = buyOrders[i].amount < sellOrders[j].amount ? buyOrders[i].amount : sellOrders[j].amount;
            buyOrders[i].amount -= amount;
            sellOrders[j].amount -= amount;
            if (buyOrders[i].amount == 0) i++;
            if (sellOrders[j].amount == 0) j++;
        } else {
            break;
        }
    }

    for (int k = i; k < buyCount; k++) {
        backlog = (backlog + buyOrders[k].amount) % 1000000007;
    }
    for (int k = j; k < sellCount; k++) {
        backlog = (backlog + sellOrders[k].amount) % 1000000007;
    }

    free(buyOrders);
    free(sellOrders);
    return (int)backlog;
}