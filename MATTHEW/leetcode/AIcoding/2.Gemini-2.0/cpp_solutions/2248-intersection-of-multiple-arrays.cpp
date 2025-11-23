#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> intersection(vector<vector<int>>& nums) {
        unordered_map<int, int> count;
        int n = nums.size();
        for (const auto& row : nums) {
            for (int num : row) {
                count[num]++;
            }
        }

        vector<int> result;
        for (auto const& [num, freq] : count) {
            if (freq == n) {
                result.push_back(num);
            }
        }

        sort(result.begin(), result.end());
        return result;
    }
};