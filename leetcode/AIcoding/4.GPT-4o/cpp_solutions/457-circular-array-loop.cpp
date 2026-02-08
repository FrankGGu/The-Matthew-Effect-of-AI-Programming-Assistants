class Solution {
public:
    bool circularArrayLoop(vector<int>& nums) {
        int n = nums.size();
        for (int i = 0; i < n; i++) {
            int slow = i, fast = i;
            bool isForward = nums[i] > 0;
            while (true) {
                slow = (slow + nums[slow] + n) % n;
                fast = (fast + nums[fast] + n) % n;
                fast = (fast + nums[fast] + n) % n;
                if (nums[slow] * (isForward ? 1 : -1) <= 0 || nums[fast] * (isForward ? 1 : -1) <= 0) break;
                if (slow == fast) {
                    if (slow == (slow + nums[slow] + n) % n) return true;
                    return true;
                }
            }
            slow = i;
            while (nums[slow] * (isForward ? 1 : -1) > 0) {
                int next = (slow + nums[slow] + n) % n;
                nums[slow] = 0;
                slow = next;
            }
        }
        return false;
    }
};