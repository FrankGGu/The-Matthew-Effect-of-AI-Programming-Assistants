#include <vector>
#include <set>
#include <algorithm>

class Solution {
public:
    long long sumImbalanceNumbers(std::vector<int>& nums) {
        long long total_imbalance = 0;
        int N = nums.size();

        for (int i = 0; i < N; ++i) {
            long long current_imbalance = 0;
            std::set<int> unique_elements;
            for (int j = i; j < N; ++j) {
                int num_j = nums[j];

                if (unique_elements.count(num_j)) {
                    total_imbalance += current_imbalance;
                    continue;
                }

                auto it = unique_elements.lower_bound(num_j); 

                int prev_val = -1; 
                if (it != unique_elements.begin()) {
                    prev_val = *std::prev(it);
                }

                int next_val = -1; 
                if (it != unique_elements.end()) {
                    next_val = *it;
                }

                if (prev_val != -1 && next_val != -1) {
                    if (next_val - prev_val > 1) {
                        current_imbalance--;
                    }
                }

                if (prev_val != -1) {
                    if (num_j - prev_val > 1) {
                        current_imbalance++;
                    }
                }

                if (next_val != -1) {
                    if (next_val - num_j > 1) {
                        current_imbalance++;
                    }
                }

                unique_elements.insert(num_j);
                total_imbalance += current_imbalance;
            }
        }

        return total_imbalance;
    }
};