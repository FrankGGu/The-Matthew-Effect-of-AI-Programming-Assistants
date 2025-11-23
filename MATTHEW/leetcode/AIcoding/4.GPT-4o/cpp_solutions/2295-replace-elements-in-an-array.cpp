class Solution {
public:
    vector<int> arrayChange(vector<int>& nums, vector<vector<int>>& operations) {
        unordered_map<int, int> numMap;
        for (int num : nums) {
            numMap[num] = num;
        }

        for (const auto& op : operations) {
            int oldNum = op[0], newNum = op[1];
            if (numMap.find(oldNum) != numMap.end()) {
                numMap[newNum] = numMap[oldNum];
                numMap.erase(oldNum);
            }
        }

        vector<int> result;
        for (const auto& pair : numMap) {
            result.push_back(pair.second);
        }
        return result;
    }
};