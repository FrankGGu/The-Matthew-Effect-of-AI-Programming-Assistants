class Solution {
    public boolean circularArrayLoop(int[] nums) {
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            int slow = i, fast = i;
            boolean isForward = nums[i] > 0;

            while (true) {
                slow = nextIndex(nums, slow, isForward);
                fast = nextIndex(nums, fast, isForward);
                if (fast != -1) {
                    fast = nextIndex(nums, fast, isForward);
                }

                if (slow == -1 || fast == -1 || slow == fast) {
                    break;
                }
            }

            if (slow != -1 && slow == fast) {
                return true;
            }
        }
        return false;
    }

    private int nextIndex(int[] nums, int current, boolean isForward) {
        int n = nums.length;
        int step = nums[current] % n;
        if (step == 0 || (isForward != (step > 0))) {
            return -1;
        }
        return (current + step + n) % n;
    }
}