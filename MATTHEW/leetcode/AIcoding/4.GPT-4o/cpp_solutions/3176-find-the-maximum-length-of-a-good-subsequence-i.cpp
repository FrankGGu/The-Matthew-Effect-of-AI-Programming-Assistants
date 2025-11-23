class Solution {
public:
    int maximumLength(vector<int>& nums) {
        unordered_set<int> seen;
        for (int num : nums) {
            if (num > 0) {
                seen.insert(num);
            }
        }
        return seen.size();
    }
};