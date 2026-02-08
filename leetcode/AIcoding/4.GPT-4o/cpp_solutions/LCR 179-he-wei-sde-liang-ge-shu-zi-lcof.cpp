class Solution {
public:
    vector<int> twoSum(vector<int>& prices, int target) {
        unordered_map<int, int> map;
        for (int i = 0; i < prices.size(); ++i) {
            int complement = target - prices[i];
            if (map.find(complement) != map.end()) {
                return {map[complement], i};
            }
            map[prices[i]] = i;
        }
        return {};
    }
};