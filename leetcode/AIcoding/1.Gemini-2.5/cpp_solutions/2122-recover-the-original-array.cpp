#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    std::vector<int> recoverArray(std::vector<int>& nums) {
        std::sort(nums.begin(), nums.end());
        int n = nums.size() / 2;

        for (int j = 1; j < nums.size(); ++j) {
            int diff = nums[j] - nums[0];
            if (diff > 0 && diff % 2 == 0) {
                int k = diff / 2;
                std::vector<int> current_lower;
                std::multiset<int> s(nums.begin(), nums.end());
                bool possible = true;

                while (!s.empty()) {
                    int l_val = *s.begin();
                    s.erase(s.begin());

                    int u_val = l_val + 2 * k;
                    auto it = s.find(u_val);

                    if (it == s.end()) {
                        possible = false;
                        break;
                    }
                    s.erase(it);
                    current_lower.push_back(l_val);
                }

                if (possible && current_lower.size() == n) {
                    return current_lower;
                }
            }
        }
        return {}; 
    }
};