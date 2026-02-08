class Solution {
public:
    int numIdenticalPairs(vector<int>& nums) {
        unordered_map<int, int> count;
        int goodPairs = 0;
        for (int num : nums) {
            goodPairs += count[num]++;
        }
        return goodPairs;
    }
};