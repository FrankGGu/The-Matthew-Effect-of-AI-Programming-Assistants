#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long findScore(vector<int>& nums) {
        int n = nums.size();
        vector<bool> marked(n, false);
        vector<pair<int, int>> indexed_nums;
        for (int i = 0; i < n; ++i) {
            indexed_nums.push_back({nums[i], i});
        }
        sort(indexed_nums.begin(), indexed_nums.end());

        long long score = 0;
        for (int i = 0; i < n; ++i) {
            int index = indexed_nums[i].second;
            if (!marked[index]) {
                score += indexed_nums[i].first;
                marked[index] = true;
                if (index > 0) {
                    marked[index - 1] = true;
                }
                if (index < n - 1) {
                    marked[index + 1] = true;
                }
            }
        }

        return score;
    }
};