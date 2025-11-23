class Solution {
public:
    long long minimalKSum(vector<int>& nums, int k) {
        unordered_set<int> seen(nums.begin(), nums.end());
        long long sum = 0;
        for (int i = 1; k > 0; ++i) {
            if (seen.find(i) == seen.end()) {
                sum += i;
                --k;
            }
        }
        return sum;
    }
};