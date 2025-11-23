class Solution {
public:
    long long maximumBeauty(vector<int>& flowers, int newFlowers, int target, int full, int partial) {
        int n = flowers.size();
        long long res = 0;
        long long totalFlowers = 0;

        vector<long long> prefix(n + 1, 0);
        sort(flowers.begin(), flowers.end());

        for (int i = 0; i < n; ++i) {
            totalFlowers += flowers[i];
            prefix[i + 1] = totalFlowers;
        }

        for (int i = 0; i <= n; ++i) {
            long long currentFlowers = (i > 0) ? prefix[i] : 0;
            long long requiredFlowers = (long long)i * target - currentFlowers;

            if (requiredFlowers <= newFlowers) {
                long long remainingFlowers = newFlowers - requiredFlowers;
                long long beauty = (long long)i * full;

                if (remainingFlowers > 0) {
                    long long canAdd = remainingFlowers / (target - 1);
                    if (canAdd > 0) {
                        beauty += min(canAdd, (long long)(n - i)) * partial;
                    }
                }

                res = max(res, beauty);
            }
        }
        return res;
    }
};