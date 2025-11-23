class Solution {
public:
    void generateSubsets(const vector<int>& nums, int start, int end, vector<int>& subsets, int sum = 0) {
        if (start == end) {
            subsets.push_back(sum);
            return;
        }
        generateSubsets(nums, start + 1, end, subsets, sum + nums[start]);
        generateSubsets(nums, start + 1, end, subsets, sum);
    }

    int minAbsDifference(vector<int>& nums, int goal) {
        int n = nums.size();
        vector<int> left, right;
        generateSubsets(nums, 0, n / 2, left);
        generateSubsets(nums, n / 2, n, right);

        sort(right.begin(), right.end());

        int res = INT_MAX;
        for (int x : left) {
            int target = goal - x;
            auto it = lower_bound(right.begin(), right.end(), target);
            if (it != right.end()) {
                res = min(res, abs(target - *it));
            }
            if (it != right.begin()) {
                --it;
                res = min(res, abs(target - *it));
            }
            if (res == 0) break;
        }
        return res;
    }
};