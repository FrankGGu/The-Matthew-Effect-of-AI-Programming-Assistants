#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> maximizeXor(vector<int>& nums, vector<vector<int>>& queries) {
        sort(nums.begin(), nums.end());
        vector<int> result;
        for (auto& query : queries) {
            int x = query[0];
            int m = query[1];
            int max_xor = -1;
            for (int num : nums) {
                if (num <= m) {
                    max_xor = max(max_xor, x ^ num);
                } else {
                    break;
                }
            }
            result.push_back(max_xor);
        }
        return result;
    }
};