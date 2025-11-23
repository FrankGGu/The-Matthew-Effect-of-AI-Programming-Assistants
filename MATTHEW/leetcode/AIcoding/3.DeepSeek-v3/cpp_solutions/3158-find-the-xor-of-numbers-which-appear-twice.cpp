class Solution {
public:
    int duplicateNumbersXOR(vector<int>& nums) {
        unordered_map<int, int> freq;
        int result = 0;
        for (int num : nums) {
            freq[num]++;
            if (freq[num] == 2) {
                result ^= num;
            }
        }
        return result;
    }
};