class Solution {
public:
    int minOperations(vector<int>& nums1, vector<int>& nums2, int x) {
        int target = 0;
        for (int num : nums1) target += num;
        for (int num : nums2) target -= num;

        if (abs(target) > x * (nums1.size() + nums2.size())) return -1;

        unordered_map<int, int> count;
        for (int num : nums1) count[num]++;
        for (int num : nums2) count[-num]++;

        int res = INT_MAX;
        for (auto& [key, val] : count) {
            if (target % key == 0) {
                res = min(res, val + abs(target / key));
            }
        }

        return res == INT_MAX ? -1 : res;
    }
};