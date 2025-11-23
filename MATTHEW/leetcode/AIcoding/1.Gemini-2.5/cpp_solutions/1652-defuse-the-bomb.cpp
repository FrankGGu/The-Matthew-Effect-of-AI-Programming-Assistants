class Solution {
public:
    std::vector<int> decrypt(std::vector<int>& code, int k) {
        int n = code.size();
        std::vector<int> result(n);

        if (k == 0) {
            return result;
        }

        if (k > 0) {
            for (int i = 0; i < n; ++i) {
                int currentSum = 0;
                for (int j = 1; j <= k; ++j) {
                    currentSum += code[(i + j) % n];
                }
                result[i] = currentSum;
            }
        } else { // k < 0
            int abs_k = -k;
            for (int i = 0; i < n; ++i) {
                int currentSum = 0;
                for (int j = 1; j <= abs_k; ++j) {
                    currentSum += code[(i - j + n) % n];
                }
                result[i] = currentSum;
            }
        }

        return result;
    }
};