class Solution {
public:
    int findSmallestInteger(vector<int>& nums, int value) {
        unordered_map<int, int> count;
        for (int num : nums) {
            int mod = (num % value + value) % value;
            count[mod]++;
        }
        for (int i = 0; i < nums.size(); ++i) {
            int mod = i % value;
            if (count[mod] == 0) {
                return i;
            }
            count[mod]--;
        }
        return nums.size();
    }
};