#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> arrayChange(vector<int>& nums, vector<vector<int>>& operations) {
        unordered_map<int, int> valueToIndex;
        for (int i = 0; i < nums.size(); ++i) {
            valueToIndex[nums[i]] = i;
        }

        for (const auto& op : operations) {
            int oldVal = op[0];
            int newVal = op[1];
            int index = valueToIndex[oldVal];
            nums[index] = newVal;
            valueToIndex.erase(oldVal);
            valueToIndex[newVal] = index;
        }

        return nums;
    }
};