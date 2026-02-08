#include <vector>
#include <map>

class Solution {
public:
    int tupleSameProduct(std::vector<int>& nums) {
        std::map<int, int> product_counts;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int product = nums[i] * nums[j];
                product_counts[product]++;
            }
        }

        long long total_tuples = 0;

        for (auto const& [product, count] : product_counts) {
            if (count >= 2) {
                total_tuples += (long long)count * (count - 1) / 2 * 8;
            }
        }

        return static_cast<int>(total_tuples);
    }
};