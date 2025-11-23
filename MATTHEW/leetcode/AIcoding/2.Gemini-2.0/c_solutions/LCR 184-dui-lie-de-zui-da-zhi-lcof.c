#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int productId;
    int price;
} Product;

typedef struct {
    Product* products;
    int capacity;
    int size;
} CheckoutSystem;

CheckoutSystem* checkoutSystemCreate() {
    CheckoutSystem* obj = (CheckoutSystem*)malloc(sizeof(CheckoutSystem));
    obj->capacity = 10;
    obj->size = 0;
    obj->products = (Product*)malloc(obj->capacity * sizeof(Product));
    return obj;
}

void checkoutSystemAddProduct(CheckoutSystem* obj, int productId, int price) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->products = (Product*)realloc(obj->products, obj->capacity * sizeof(Product));
    }
    obj->products[obj->size].productId = productId;
    obj->products[obj->size].price = price;
    obj->size++;
}

int checkoutSystemCalculatePrice(CheckoutSystem* obj, int* productIds, int productIdsSize) {
    int totalPrice = 0;
    for (int i = 0; i < productIdsSize; i++) {
        int productId = productIds[i];
        for (int j = 0; j < obj->size; j++) {
            if (obj->products[j].productId == productId) {
                totalPrice += obj->products[j].price;
                break;
            }
        }
    }
    return totalPrice;
}

void checkoutSystemFree(CheckoutSystem* obj) {
    free(obj->products);
    free(obj);
}