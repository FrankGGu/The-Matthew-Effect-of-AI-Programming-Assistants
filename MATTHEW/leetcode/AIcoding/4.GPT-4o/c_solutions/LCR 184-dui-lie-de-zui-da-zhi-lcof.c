typedef struct {
    int productId;
    int price;
} Product;

typedef struct {
    Product* products;
    int size;
} Checkout;

Checkout* checkoutCreate(int* items, int itemsSize) {
    Checkout* checkout = malloc(sizeof(Checkout));
    checkout->products = malloc(itemsSize * sizeof(Product));
    checkout->size = itemsSize;
    for (int i = 0; i < itemsSize; i++) {
        checkout->products[i].productId = i + 1;
        checkout->products[i].price = items[i];
    }
    return checkout;
}

int checkoutGetTotal(Checkout* obj, int* productIds, int productIdsSize) {
    int total = 0;
    for (int i = 0; i < productIdsSize; i++) {
        total += obj->products[productIds[i] - 1].price;
    }
    return total;
}

void checkoutFree(Checkout* obj) {
    free(obj->products);
    free(obj);
}