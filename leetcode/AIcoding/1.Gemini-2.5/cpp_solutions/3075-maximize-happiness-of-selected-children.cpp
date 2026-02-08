#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    long long maximizeHappiness(std::vector<int>& happiness, int k) {
        std::sort(happiness.rbegin(), happiness.rend());

        long long total_happiness = 0;
        for (int i = 0; i < k; ++i) {
            long long current_child_happiness = happiness[i];
            long long adjusted_happiness = current_child_happiness - i;

            if (adjusted_happiness > 0) {
                total_happiness += adjusted_happiness;
            } else {
                break; 
            }
        }

        return total_happiness;
    }
};