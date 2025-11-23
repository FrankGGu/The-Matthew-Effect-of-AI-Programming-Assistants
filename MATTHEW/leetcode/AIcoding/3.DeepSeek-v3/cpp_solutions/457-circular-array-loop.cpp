class Solution {
public:
    bool circularArrayLoop(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return false;

        for (int i = 0; i < n; ++i) {
            if (nums[i] == 0) continue;

            int slow = i, fast = getNext(nums, i);
            while (nums[slow] * nums[fast] > 0 && nums[slow] * nums[getNext(nums, fast)] > 0) {
                if (slow == fast) {
                    if (slow == getNext(nums, slow)) break;
                    return true;
                }
                slow = getNext(nums, slow);
                fast = getNext(nums, getNext(nums, fast));
            }

            slow = i;
            int val = nums[slow];
            while (nums[slow] * val > 0) {
                int next = getNext(nums, slow);
                nums[slow] = 0;
                slow = next;
            }
        }

        return false;
    }

private:
    int getNext(vector<int>& nums, int i) {
        int n = nums.size();
        return (i + nums[i] % n + n) % n;
    }
};