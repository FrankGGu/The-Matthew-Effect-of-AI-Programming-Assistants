int maxProfit(int* inventory, int inventorySize, int orders) {
    long long left = 1, right = 0, mod = 1e9 + 7;
    for (int i = 0; i < inventorySize; i++) {
        if (inventory[i] > right) {
            right = inventory[i];
        }
    }

    long long total = 0;

    while (orders > 0) {
        long long mid = (left + right) / 2;
        long long count = 0;

        for (int i = 0; i < inventorySize; i++) {
            if (inventory[i] > mid) {
                count += inventory[i] - mid;
            }
        }

        if (count >= orders) {
            total = (total + (mid * orders) % mod) % mod;
            orders = 0;
            break;
        } else {
            total = (total + (mid * count) % mod) % mod;
            orders -= count;
            left = mid + 1;
        }
    }

    if (orders > 0) {
        total = (total + (left * orders) % mod) % mod;
    }

    return total;
}