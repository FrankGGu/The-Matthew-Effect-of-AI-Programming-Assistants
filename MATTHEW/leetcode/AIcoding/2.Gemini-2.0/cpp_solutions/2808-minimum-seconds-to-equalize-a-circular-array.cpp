#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minimumSeconds(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, vector<int>> pos;
        for (int i = 0; i < n; ++i) {
            pos[nums[i]].push_back(i);
        }

        int ans = n;
        for (auto& [num, indices] : pos) {
            int max_diff = 0;
            for (int i = 0; i < indices.size(); ++i) {
                int diff;
                if (i == 0) {
                    diff = indices[0] + (n - indices.back());
                } else {
                    diff = indices[i] - indices[i - 1];
                }
                max_diff = max(max_diff, diff);
            }
            ans = min(ans, max_diff / 2);
        }

        return ans;
    }
};