#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> arrayChange(vector<int>& nums, vector<vector<int>>& operations) {
        unordered_map<int, int> numToIndex;
        for (int i = 0; i < nums.size(); ++i) {
            numToIndex[nums[i]] = i;
        }

        for (auto& op : operations) {
            int prev = op[0];
            int next = op[1];
            int index = numToIndex[prev];
            nums[index] = next;
            numToIndex.erase(prev);
            numToIndex[next] = index;
        }

        return nums;
    }
};