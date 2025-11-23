class Solution {
    public int maximumANDSum(int[] nums, int numSlots) {
        int n = nums.length;
        int[] slots = new int[numSlots + 1];
        for (int i = 1; i <= numSlots; i++) {
            slots[i] = 2;
        }

        Integer[][] memo = new Integer[n + 1][(int) Math.pow(3, numSlots)];

        return solve(nums, 0, slots, numSlots, memo);
    }

    private int solve(int[] nums, int idx, int[] slots, int numSlots, Integer[][] memo) {
        if (idx == nums.length) {
            return 0;
        }

        int state = getState(slots, numSlots);
        if (memo[idx][state] != null) {
            return memo[idx][state];
        }

        int maxAndSum = 0;
        for (int i = 1; i <= numSlots; i++) {
            if (slots[i] > 0) {
                slots[i]--;
                maxAndSum = Math.max(maxAndSum, (nums[idx] & i) + solve(nums, idx + 1, slots, numSlots, memo));
                slots[i]++;
            }
        }

        return memo[idx][state] = maxAndSum;
    }

    private int getState(int[] slots, int numSlots) {
        int state = 0;
        int power = 1;
        for (int i = 1; i <= numSlots; i++) {
            state += slots[i] * power;
            power *= 3;
        }
        return state;
    }
}