#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int miceAndCheese(std::vector<int>& reward1, std::vector<int>& reward2, int k) {
        int n = reward1.size();
        std::vector<int> diffs(n);
        long long total_score = 0;

        for (int i = 0; i < n; ++i) {
            diffs[i] = reward1[i] - reward2[i];
            total_score += reward2[i];
        }

        std::sort(diffs.rbegin(), diffs.rend());

        for (int i = 0; i < k; ++i) {
            total_score += diffs[i];
        }

        return static_cast<int>(total_score);
    }
};