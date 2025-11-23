#include <vector>
#include <algorithm>

class Solution {
public:
    int maxSubArray(std::vector<int>& sales) {
        if (sales.empty()) {
            return 0; 
        }

        int max_so_far = sales[0];
        int current_max = sales[0];

        for (size_t i = 1; i < sales.size(); ++i) {
            current_max = std::max(sales[i], current_max + sales[i]);
            max_so_far = std::max(max_so_far, current_max);
        }

        return max_so_far;
    }
};