class Solution {
public:
    int minOperations(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }
        return freq.size();
    }
};