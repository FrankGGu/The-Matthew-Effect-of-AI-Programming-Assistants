int minOperations(int* inventory, int inventorySize, int orders) {
    long long total = 0;
    for (int i = 0; i < inventorySize; i++) {
        total += inventory[i];
    }

    long long low = 1, high = total / orders + 1, ans = 0;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        long long needed = 0;

        for (int i = 0; i < inventorySize; i++) {
            if (inventory[i] > mid) {
                needed += inventory[i] - mid;
            }
        }

        if (needed >= orders) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return total - ans * orders;
}