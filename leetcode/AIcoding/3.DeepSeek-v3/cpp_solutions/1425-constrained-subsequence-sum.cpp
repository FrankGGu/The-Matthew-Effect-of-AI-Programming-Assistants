class Solution {
public:
    int constrainedSubsetSum(vector<int>& nums, int k) {
        deque<int> dq;
        int res = nums[0];
        for (int i = 0; i < nums.size(); ++i) {
            nums[i] += !dq.empty() ? nums[dq.front()] : 0;
            res = max(res, nums[i]);
            while (!dq.empty() && nums[i] > nums[dq.back()]) {
                dq.pop_back();
            }
            if (nums[i] > 0) {
                dq.push_back(i);
            }
            while (!dq.empty() && i - dq.front() >= k) {
                dq.pop_front();
            }
        }
        return res;
    }
};