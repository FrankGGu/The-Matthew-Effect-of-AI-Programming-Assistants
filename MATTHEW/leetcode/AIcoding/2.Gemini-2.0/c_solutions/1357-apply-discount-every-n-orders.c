#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int n;
    int discount;
    int* products;
    int productsSize;
    int* prices;
    int pricesSize;
    int orderCount;
} Cashier;

Cashier* cashierCreate(int n, int discount, int* products, int productsSize, int* prices, int pricesSize) {
    Cashier* obj = (Cashier*)malloc(sizeof(Cashier));
    obj->n = n;
    obj->discount = discount;
    obj->products = (int*)malloc(productsSize * sizeof(int));
    for (int i = 0; i < productsSize; i++) {
        obj->products[i] = products[i];
    }
    obj->productsSize = productsSize;
    obj->prices = (int*)malloc(pricesSize * sizeof(int));
    for (int i = 0; i < pricesSize; i++) {
        obj->prices[i] = prices[i];
    }
    obj->pricesSize = pricesSize;
    obj->orderCount = 0;
    return obj;
}

double cashierGetBill(Cashier* obj, int* product, int productSize, int* amount, int amountSize) {
    obj->orderCount++;
    double total = 0.0;
    for (int i = 0; i < productSize; i++) {
        for (int j = 0; j < obj->productsSize; j++) {
            if (product[i] == obj->products[j]) {
                total += (double)amount[i] * (double)obj->prices[j];
                break;
            }
        }
    }
    if (obj->orderCount % obj->n == 0) {
        total = total * (100.0 - (double)obj->discount) / 100.0;
    }
    return total;
}

void cashierFree(Cashier* obj) {
    free(obj->products);
    free(obj->prices);
    free(obj);
}