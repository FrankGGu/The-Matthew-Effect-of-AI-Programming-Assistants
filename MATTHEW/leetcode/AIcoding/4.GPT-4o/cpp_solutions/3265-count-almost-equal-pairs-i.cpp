class Solution {
public:
    int countAlmostEqualPairs(vector<int>& nums) {
        int count = 0;
        unordered_map<int, int> freq;

        for (int num : nums) {
            count += freq[num + 1] + freq[num - 1];
            freq[num]++;
        }

        return count;
    }
};