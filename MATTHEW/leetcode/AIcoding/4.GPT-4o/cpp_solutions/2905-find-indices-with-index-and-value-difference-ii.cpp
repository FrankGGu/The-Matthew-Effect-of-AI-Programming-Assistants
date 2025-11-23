class Solution {
public:
    vector<int> findIndices(vector<int>& nums, int diff) {
        unordered_map<int, int> indexMap;
        vector<int> result;

        for (int i = 0; i < nums.size(); ++i) {
            if (indexMap.count(nums[i] - diff)) {
                result.push_back(indexMap[nums[i] - diff]);
                result.push_back(i);
                return result;
            }
            if (indexMap.count(nums[i] + diff)) {
                result.push_back(i);
                result.push_back(indexMap[nums[i] + diff]);
                return result;
            }
            indexMap[nums[i]] = i;
        }
        return result;
    }
};