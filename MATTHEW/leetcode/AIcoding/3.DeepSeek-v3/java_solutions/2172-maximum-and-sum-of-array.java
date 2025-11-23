class Solution {
    public int maximumANDSum(int[] nums, int numSlots) {
        int[] slots = new int[numSlots + 1];
        return backtrack(nums, slots, 0);
    }

    private int backtrack(int[] nums, int[] slots, int index) {
        if (index == nums.length) {
            return 0;
        }
        int max = 0;
        for (int i = 1; i < slots.length; i++) {
            if (slots[i] < 2) {
                slots[i]++;
                int current = (nums[index] & i) + backtrack(nums, slots, index + 1);
                max = Math.max(max, current);
                slots[i]--;
            }
        }
        return max;
    }
}