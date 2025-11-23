class Solution {
public:
    vector<int> countSmaller(vector<int>& nums) {
        vector<int> result(nums.size(), 0);
        vector<pair<int, int>> numIndex;

        for (int i = 0; i < nums.size(); ++i) {
            numIndex.push_back({nums[i], i});
        }

        sort(numIndex.begin(), numIndex.end());

        for (int i = 0; i < nums.size(); ++i) {
            result[numIndex[i].second] = i;
        }

        return result;
    }
};