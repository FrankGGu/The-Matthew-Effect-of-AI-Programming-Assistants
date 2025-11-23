class Solution {
public:
    int distinctElementSumOfSquares(vector<int>& nums) {
        int n = nums.size();
        unordered_set<int> distinctElements;
        long long sum = 0;

        for (int i = 0; i < n; i++) {
            distinctElements.clear();
            for (int j = i; j < n; j++) {
                distinctElements.insert(nums[j]);
                sum += distinctElements.size() * distinctElements.size();
            }
        }

        return sum % 1000000007;
    }
};