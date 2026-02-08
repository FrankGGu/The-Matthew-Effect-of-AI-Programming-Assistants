#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int count;
    int n;
    double discount;
} Cashier;

Cashier* cashierCreate(int n, int discount, int* products, int productsSize, int* prices, int pricesSize) {
    Cashier* obj = (Cashier*)malloc(sizeof(Cashier));
    obj->count = 0;
    obj->n = n;
    obj->discount = (double)discount / 100.0;
    return obj;
}

double cashierGetBill(int* product, int productSize, Cashier* obj) {
    double total = 0.0;
    for (int i = 0; i < productSize; i++) {
        // Assume that the price of each product is stored in a map or array
        // For this problem, we will assume that the prices are provided in the same order as products
        // This is a simplification for LeetCode's input format
        total += prices[i];
    }
    obj->count++;
    if (obj->count % obj->n == 0) {
        total *= (1.0 - obj->discount);
    }
    return total;
}

void cashierFree(Cashier* obj) {
    free(obj);
}