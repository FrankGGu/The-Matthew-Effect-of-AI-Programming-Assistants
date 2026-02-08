class Solution {
public:
    long long maxArrayValue(vector<int>& nums) {
        vector<long long> arr(nums.begin(), nums.end());
        int n = arr.size();
        for (int i = n - 1; i > 0; --i) {
            if (arr[i - 1] <= arr[i]) {
                arr[i - 1] += arr[i];
            }
        }
        return arr[0];
    }
};