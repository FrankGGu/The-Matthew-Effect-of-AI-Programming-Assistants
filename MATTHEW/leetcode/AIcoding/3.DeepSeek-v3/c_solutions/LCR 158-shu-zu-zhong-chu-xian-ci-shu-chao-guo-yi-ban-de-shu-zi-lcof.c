int inventoryManagement(int* stock, int stockSize) {
    int candidate = stock[0];
    int count = 1;

    for (int i = 1; i < stockSize; i++) {
        if (stock[i] == candidate) {
            count++;
        } else {
            count--;
            if (count == 0) {
                candidate = stock[i];
                count = 1;
            }
        }
    }

    return candidate;
}