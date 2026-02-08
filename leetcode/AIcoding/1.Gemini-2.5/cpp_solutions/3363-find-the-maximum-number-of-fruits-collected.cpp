#include <vector>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int maxTotalFruits(std::vector<std::vector<int>>& fruits, int startPos, int k) {
        int n = fruits.size();

        std::vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + fruits[i][1];
        }

        long long maxFruits = 0;
        int left = 0;
        for (int right = 0; right < n; ++right) {
            long long pos_right = fruits[right][0];

            while (left <= right) {
                long long pos_left = fruits[left][0];

                long long cost1 = (pos_right - startPos) + (pos_right - pos_left);
                long long cost2 = (startPos - pos_left) + (pos_right - pos_left);

                long long cost = std::min(cost1, cost2);

                if (pos_right <= startPos) {
                    cost = startPos - pos_left;
                } else if (pos_left >= startPos) {
                    cost = pos_right - startPos;
                }

                if (cost > k) {
                    left++;
                } else {
                    break;
                }
            }

            if (left <= right) {
                maxFruits = std::max(maxFruits, prefixSum[right + 1] - prefixSum[left]);
            }
        }

        return static_cast<int>(maxFruits);
    }
};