class Solution {
public:
    int minOperations(vector<int>& nums, vector<int>& target) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int operations = 0;
        for (int t : target) {
            if (freq[t] > 0) {
                freq[t]--;
            } else {
                operations++;
            }
        }
        return operations;
    }
};