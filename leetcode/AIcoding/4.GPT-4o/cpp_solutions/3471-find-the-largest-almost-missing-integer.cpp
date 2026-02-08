class Solution {
public:
    int findLargestInteger(vector<int>& nums) {
        unordered_set<int> numSet(nums.begin(), nums.end());
        int largest = -1;
        for (int i = 1; i <= 1000; ++i) {
            if (numSet.find(i) == numSet.end() && numSet.find(i + 1) != numSet.end()) {
                largest = i;
            }
        }
        return largest;
    }
};