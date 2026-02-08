typedef struct {
    int n;
    int discount;
    int* products;
    int productsSize;
    int* prices;
    int count;
} Cashier;

Cashier* cashierCreate(int n, int discount, int* products, int productsSize, int* prices, int pricesSize) {
    Cashier* obj = (Cashier*)malloc(sizeof(Cashier));
    obj->n = n;
    obj->discount = discount;
    obj->productsSize = productsSize;
    obj->products = (int*)malloc(productsSize * sizeof(int));
    obj->prices = (int*)malloc(productsSize * sizeof(int));
    for (int i = 0; i < productsSize; i++) {
        obj->products[i] = products[i];
        obj->prices[i] = prices[i];
    }
    obj->count = 0;
    return obj;
}

double cashierGetBill(Cashier* obj, int* product, int productSize, int* amount, int amountSize) {
    obj->count++;
    double total = 0.0;
    for (int i = 0; i < productSize; i++) {
        for (int j = 0; j < obj->productsSize; j++) {
            if (product[i] == obj->products[j]) {
                total += obj->prices[j] * amount[i];
                break;
            }
        }
    }
    if (obj->count % obj->n == 0) {
        total = total * (1 - obj->discount / 100.0);
    }
    return total;
}

void cashierFree(Cashier* obj) {
    free(obj->products);
    free(obj->prices);
    free(obj);
}