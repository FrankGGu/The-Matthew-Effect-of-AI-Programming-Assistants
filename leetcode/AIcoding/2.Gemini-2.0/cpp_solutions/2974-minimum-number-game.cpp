#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> numberGame(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        vector<int> result;
        for (int i = 0; i < nums.size(); i += 2) {
            result.push_back(nums[i + 1]);
            result.push_back(nums[i]);
        }
        return result;
    }
};