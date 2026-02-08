#include <stdbool.h> // Required for 'true' keyword
#include <stdlib.h>  // Required for NULL, potentially for malloc if dynamic allocation was used
#include <string.h>  // Required for memset if array initialization was needed, not strictly here

#define MAX_HEAP_SIZE 100005
#define MOD 1000000007

typedef struct {
    int price;
    int amount;
} Order;

Order buyHeap[MAX_HEAP_SIZE];
int buyHeapSize = 0;

void buyHeapPush(Order item) {
    buyHeap[buyHeapSize] = item;
    int current = buyHeapSize;
    while (current > 0) {
        int parent = (current - 1) / 2;
        if (buyHeap[current].price > buyHeap[parent].price) {
            Order temp = buyHeap[current];
            buyHeap[current] = buyHeap[parent];
            buyHeap[parent] = temp;
            current = parent;
        } else {
            break;
        }
    }
    buyHeapSize++;
}

Order buyHeapPop() {
    Order root = buyHeap[0];
    buyHeapSize--;
    if (buyHeapSize > 0) {
        buyHeap[0] = buyHeap[buyHeapSize];
        int current = 0;
        while (true) {
            int leftChild = 2 * current + 1;
            int rightChild = 2 * current + 2;
            int largest = current;

            if (leftChild < buyHeapSize && buyHeap[leftChild].price > buyHeap[largest].price) {
                largest = leftChild;
            }
            if (rightChild < buyHeapSize && buyHeap[rightChild].price > buyHeap[largest].price) {
                largest = rightChild;
            }

            if (largest != current) {
                Order temp = buyHeap[current];
                buyHeap[current] = buyHeap[largest];
                buyHeap[largest] = temp;
                current = largest;
            } else {
                break;
            }
        }
    }
    return root;
}

Order buyHeapPeek() {
    return buyHeap[0];
}

Order sellHeap[MAX_HEAP_SIZE];
int sellHeapSize = 0;

void sellHeapPush(Order item) {
    sellHeap[sellHeapSize] = item;
    int current = sellHeapSize;
    while (current > 0) {
        int parent = (current - 1) / 2;
        if (sellHeap[current].price < sellHeap[parent].price) {
            Order temp = sellHeap[current];
            sellHeap[current] = sellHeap[parent];
            sellHeap[parent] = temp;
            current = parent;
        } else {
            break;
        }
    }
    sellHeapSize++;
}

Order sellHeapPop() {
    Order root = sellHeap[0];
    sellHeapSize--;
    if (sellHeapSize > 0) {
        sellHeap[0] = sellHeap[sellHeapSize];
        int current = 0;
        while (true) {
            int leftChild = 2 * current + 1;
            int rightChild = 2 * current + 2;
            int smallest = current;

            if (leftChild < sellHeapSize && sellHeap[leftChild].price < sellHeap[smallest].price) {
                smallest = leftChild;
            }
            if (rightChild < sellHeapSize && sellHeap[rightChild].price < sellHeap[smallest].price) {
                smallest = rightChild;
            }

            if (smallest != current) {
                Order temp = sellHeap[current];
                sellHeap[current] = sellHeap[smallest];
                sellHeap[smallest] = temp;
                current = smallest;
            } else {
                break;
            }
        }
    }
    return root;
}

Order sellHeapPeek() {
    return sellHeap[0];
}

int min(int a, int b) {
    return a < b ? a : b;
}

int getNumberOfBacklogOrders(int** orders, int ordersSize, int* ordersColSize) {
    buyHeapSize = 0;
    sellHeapSize = 0;

    for (int i = 0; i < ordersSize; i++) {
        int price = orders[i][0];
        int amount = orders[i][1];
        int type = orders[i][2]; // 0 for buy, 1 for sell

        if (type == 0) { // Buy order
            while (amount > 0 && sellHeapSize > 0 && sellHeapPeek().price <= price) {
                int tradeAmount = min(amount, sellHeap[0].amount);
                amount -= tradeAmount;

                sellHeap[0].amount -= tradeAmount; 
                if (sellHeap[0].amount == 0) {
                    sellHeapPop();
                }
            }
            if (amount > 0) {
                buyHeapPush((Order){price, amount});
            }
        } else { // Sell order
            while (amount > 0 && buyHeapSize > 0 && buyHeapPeek().price >= price) {
                int tradeAmount = min(amount, buyHeap[0].amount);
                amount -= tradeAmount;

                buyHeap[0].amount -= tradeAmount;
                if (buyHeap[0].amount == 0) {
                    buyHeapPop();
                }
            }
            if (amount > 0) {
                sellHeapPush((Order){price, amount});
            }
        }
    }

    long long totalBacklog = 0;
    for (int i = 0; i < buyHeapSize; i++) {
        totalBacklog = (totalBacklog + buyHeap[i].amount) % MOD;
    }
    for (int i = 0; i < sellHeapSize; i++) {
        totalBacklog = (totalBacklog + sellHeap[i].amount) % MOD;
    }

    return (int)totalBacklog;
}