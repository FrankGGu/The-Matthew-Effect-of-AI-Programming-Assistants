class Solution {
public:
    int minOperations(vector<int>& nums) {
        int maxCount = 0;
        unordered_map<int, int> count;
        for (int num : nums) {
            if (num == 1) return 0;
            count[num]++;
            maxCount = max(maxCount, count[num]);
        }
        return nums.size() - maxCount;
    }
};