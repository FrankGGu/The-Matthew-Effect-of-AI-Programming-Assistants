int maxNumberOfAlloys(int n, int k, int budget, int** composition, int compositionSize, int* compositionColSize, int* stock, int stockSize, int* cost, int costSize) {
    int left = 0, right = 200000000;
    int ans = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        long long min_cost = LLONG_MAX;

        for (int i = 0; i < k; i++) {
            long long total_cost = 0;
            for (int j = 0; j < n; j++) {
                long long need = (long long)composition[i][j] * mid - stock[j];
                if (need > 0) {
                    total_cost += need * cost[j];
                    if (total_cost > budget) break;
                }
            }
            if (total_cost < min_cost) {
                min_cost = total_cost;
            }
        }

        if (min_cost <= budget) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
}