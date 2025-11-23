#include <stdlib.h>

#define MAX_PRODUCT_ID 200

typedef struct {
    int n;
    int discount;
    int order_count;
    double prices[MAX_PRODUCT_ID + 1];
} Cashier;

Cashier* cashierCreate(int n, int discount, int* products, int productsSize, int* prices, int pricesSize) {
    Cashier* obj = (Cashier*)malloc(sizeof(Cashier));
    obj->n = n;
    obj->discount = discount;
    obj->order_count = 0;

    for (int i = 0; i < pricesSize; i++) {
        obj->prices[products[i]] = (double)prices[i];
    }

    return obj;
}

double cashierGetBill(Cashier* obj, int* product, int productSize, int* amount, int amountSize) {
    obj->order_count++;
    double total_bill = 0.0;

    for (int i = 0; i < productSize; i++) {
        total_bill += obj->prices[product[i]] * amount[i];
    }

    if (obj->order_count % obj->n == 0) {
        total_bill = total_bill * (100.0 - obj->discount) / 100.0;
    }

    return total_bill;
}

void cashierFree(Cashier* obj) {
    free(obj);
}