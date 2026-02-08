class Solution {
public:
    int maxOperations(vector<int>& nums, int k) {
        unordered_map<int, int> count;
        int operations = 0;

        for (int num : nums) {
            if (count[k - num] > 0) {
                operations++;
                count[k - num]--;
            } else {
                count[num]++;
            }
        }

        return operations;
    }
};