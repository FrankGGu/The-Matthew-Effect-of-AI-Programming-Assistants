class Solution {
public:
    int minOperations(vector<int>& nums) {
        int maxCount = 0;
        unordered_map<int, int> countMap;
        for (int num : nums) {
            maxCount = max(maxCount, ++countMap[num]);
        }
        return nums.size() - maxCount;
    }
};