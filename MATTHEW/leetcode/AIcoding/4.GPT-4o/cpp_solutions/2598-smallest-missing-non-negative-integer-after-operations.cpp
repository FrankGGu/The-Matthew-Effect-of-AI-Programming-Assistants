class Solution {
public:
    int findSmallestInteger(vector<int>& nums, int value) {
        unordered_map<int, int> count;
        int n = nums.size();
        for (int num : nums) {
            count[(num % value + value) % value]++;
        }
        for (int i = 0; i < n; i++) {
            int mod = (i % value + value) % value;
            if (count[mod] == 0) {
                return i;
            }
            count[mod]--;
        }
        return n;
    }
};