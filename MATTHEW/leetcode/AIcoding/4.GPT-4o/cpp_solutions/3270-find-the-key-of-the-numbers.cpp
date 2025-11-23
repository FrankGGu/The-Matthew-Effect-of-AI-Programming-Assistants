class Solution {
public:
    int findKey(vector<int>& nums, int key) {
        unordered_map<int, int> countMap;
        for (int num : nums) {
            countMap[num]++;
        }
        return countMap[key];
    }
};