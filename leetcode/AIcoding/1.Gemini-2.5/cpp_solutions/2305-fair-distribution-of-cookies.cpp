#include <vector>
#include <numeric>
#include <algorithm>
#include <climits>

class Solution {
private:
    std::vector<int> cookies;
    int k;
    std::vector<int> child_sums;
    int min_unfairness;

    void dfs(int cookie_idx) {
        if (cookie_idx == cookies.size()) {
            int current_max_sum = 0;
            for (int sum : child_sums) {
                current_max_sum = std::max(current_max_sum, sum);
            }
            min_unfairness = std::min(min_unfairness, current_max_sum);
            return;
        }

        for (int i = 0; i < k; ++i) {
            child_sums[i] += cookies[cookie_idx];

            if (child_sums[i] < min_unfairness) {
                dfs(cookie_idx + 1);
            }

            child_sums[i] -= cookies[cookie_idx];

            if (child_sums[i] == 0) {
                break; 
            }
        }
    }

public:
    int distributeCookies(std::vector<int>& cookies_input, int k_input) {
        cookies = cookies_input;
        k = k_input;
        child_sums.assign(k, 0);
        min_unfairness = INT_MAX;

        std::sort(cookies.rbegin(), cookies.rend());

        dfs(0);
        return min_unfairness;
    }
};