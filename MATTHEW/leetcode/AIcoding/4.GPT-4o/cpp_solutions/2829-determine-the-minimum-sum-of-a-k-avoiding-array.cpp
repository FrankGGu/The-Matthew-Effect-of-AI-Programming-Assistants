class Solution {
public:
    int minimumSum(int n, int k) {
        vector<bool> used(n + 1, false);
        int sum = 0, count = 0, num = 1;

        while (count < n) {
            if (!used[num]) {
                sum += num;
                used[num] = true;
                count++;
                for (int i = 1; i < k; i++) {
                    if (num + i <= n) {
                        used[num + i] = true;
                    }
                }
            }
            num++;
        }

        return sum;
    }
};