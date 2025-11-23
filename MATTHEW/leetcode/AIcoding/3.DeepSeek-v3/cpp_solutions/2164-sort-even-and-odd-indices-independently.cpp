class Solution {
public:
    vector<int> sortEvenOdd(vector<int>& nums) {
        vector<int> even, odd;
        for (int i = 0; i < nums.size(); ++i) {
            if (i % 2 == 0) {
                even.push_back(nums[i]);
            } else {
                odd.push_back(nums[i]);
            }
        }
        sort(even.begin(), even.end());
        sort(odd.begin(), odd.end(), greater<int>());
        vector<int> result;
        int e = 0, o = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (i % 2 == 0) {
                result.push_back(even[e++]);
            } else {
                result.push_back(odd[o++]);
            }
        }
        return result;
    }
};