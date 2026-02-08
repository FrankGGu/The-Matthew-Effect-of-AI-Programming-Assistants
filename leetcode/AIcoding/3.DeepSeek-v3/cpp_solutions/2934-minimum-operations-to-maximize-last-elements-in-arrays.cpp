class Solution {
public:
    int minOperations(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size();
        int res = INT_MAX;

        auto check = [&](int a, int b) {
            int cnt = 0;
            for (int i = 0; i < n - 1; ++i) {
                if (nums1[i] <= a && nums2[i] <= b) continue;
                else if (nums2[i] <= a && nums1[i] <= b) ++cnt;
                else return INT_MAX;
            }
            return cnt;
        };

        int option1 = check(nums1.back(), nums2.back());
        int option2 = check(nums2.back(), nums1.back()) + 1;

        res = min(option1, option2);
        return res == INT_MAX ? -1 : res;
    }
};