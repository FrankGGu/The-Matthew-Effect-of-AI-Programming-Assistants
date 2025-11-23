class Solution {
public:
    int minMoves(vector<int>& nums, int limit) {
        int n = nums.size();
        vector<int> delta(2 * limit + 2, 0);

        for (int i = 0; i < n / 2; ++i) {
            int a = nums[i], b = nums[n - 1 - i];
            int left = 2, right = 2 * limit;
            delta[left] += 2;
            delta[right + 1] -= 2;

            left = 1 + min(a, b);
            right = limit + max(a, b);
            delta[left] += -1;
            delta[right + 1] -= -1;

            left = a + b;
            right = a + b;
            delta[left] += -1;
            delta[right + 1] -= -1;
        }

        int res = n, current = 0;
        for (int i = 2; i <= 2 * limit; ++i) {
            current += delta[i];
            res = min(res, current);
        }

        return res;
    }
};