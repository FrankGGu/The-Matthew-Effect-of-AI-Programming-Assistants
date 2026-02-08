typedef struct {
    int* prices;
    int* discounts;
    int n;
    int front;
    int rear;
} Checkout;

Checkout* checkoutCreate(int* prices, int pricesSize, int* discounts, int discountsSize, int n) {
    Checkout* obj = (Checkout*)malloc(sizeof(Checkout));
    obj->prices = (int*)malloc(sizeof(int) * n);
    obj->discounts = (int*)malloc(sizeof(int) * n);
    obj->n = n;
    obj->front = 0;
    obj->rear = 0;

    for (int i = 0; i < pricesSize && i < n; i++) {
        obj->prices[obj->rear] = prices[i];
        obj->discounts[obj->rear] = discounts[i];
        obj->rear = (obj->rear + 1) % n;
    }
    return obj;
}

int checkoutGetBill(Checkout* obj, int* bill, int billSize, int* discount, int discountSize) {
    if (obj->front == obj->rear) return 0;

    int total = 0;
    for (int i = 0; i < billSize; i++) {
        int idx = (obj->front + bill[i]) % obj->n;
        int price = obj->prices[idx];
        int disc = obj->discounts[idx];
        total += price * (100 - disc) / 100;
    }

    for (int i = 0; i < discountSize; i++) {
        int idx = (obj->front + discount[i]) % obj->n;
        obj->prices[idx] = obj->prices[idx] * (100 - 10) / 100;
    }

    obj->front = (obj->front + 1) % obj->n;
    return total;
}

void checkoutFree(Checkout* obj) {
    free(obj->prices);
    free(obj->discounts);
    free(obj);
}