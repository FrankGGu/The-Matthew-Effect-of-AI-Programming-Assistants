int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int maxProfit(int* inventory, int inventorySize, int orders) {
    qsort(inventory, inventorySize, sizeof(int), cmp);

    long long result = 0;
    int mod = 1000000007;
    int i = 0;
    long long current = inventory[0];

    while (orders > 0) {
        while (i < inventorySize && inventory[i] == current) {
            i++;
        }
        long long next = i == inventorySize ? 0 : inventory[i];
        long long height = current - next;
        long long total = height * i;

        if (total <= orders) {
            long long sum = (current + next + 1) * height / 2 % mod;
            result = (result + sum * i) % mod;
            orders -= total;
        } else {
            height = orders / i;
            long long remainder = orders % i;
            long long sum = (current + current - height + 1) * height / 2 % mod;
            result = (result + sum * i) % mod;
            result = (result + (current - height) * remainder) % mod;
            orders = 0;
        }
        current = next;
    }

    return result;
}