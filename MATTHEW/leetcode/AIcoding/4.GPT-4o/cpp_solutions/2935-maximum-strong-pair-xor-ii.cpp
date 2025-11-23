class Solution {
public:
    int maximumStrongPairXOR(vector<int>& nums) {
        int maxXOR = 0;
        unordered_set<int> seen;
        for (int num : nums) {
            for (int x : seen) {
                maxXOR = max(maxXOR, num ^ x);
            }
            seen.insert(num);
        }
        return maxXOR;
    }
};