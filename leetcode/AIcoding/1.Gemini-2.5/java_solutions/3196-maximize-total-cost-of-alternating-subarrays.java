class Solution {
    public long maximizeTotalCost(int[] nums) {
        int n = nums.length;
        if (n == 0) {
            return 0;
        }

        // prevAdd represents the maximum total cost for the prefix ending at the previous index (i-1),
        // where nums[i-1] was added (it was the 1st, 3rd, 5th, ... element of its subarray).
        long prevAdd = nums[0];

        // prevSub represents the maximum total cost for the prefix ending at the previous index (i-1),
        // where nums[i-1] was subtracted (it was the 2nd, 4th, 6th, ... element of its subarray).
        // It's impossible for the very first element (nums[0]) to be subtracted, so initialize with a very small value.
        long prevSub = Long.MIN_VALUE; 

        for (int i = 1; i < n; i++) {
            long currAdd;
            long currSub;

            // Calculate currAdd (max cost ending at index i, with nums[i] being added):
            // Option 1: nums[i] starts a new alternating subarray.
            // The total cost up to i-1 would be max(prevAdd, prevSub). Then add nums[i].
            // Option 2: nums[i] extends an alternating subarray where nums[i-1] was subtracted.
            // The total cost up to i-1 was prevSub. Then add nums[i].
            // We take the maximum of these two possibilities.
            // Note: If prevSub is Long.MIN_VALUE, then prevSub + nums[i] will still be effectively Long.MIN_VALUE.
            currAdd = Math.max(prevAdd + nums[i], prevSub + nums[i]);

            // Calculate currSub (max cost ending at index i, with nums[i] being subtracted):
            // This is only possible if nums[i] extends an alternating subarray where nums[i-1] was added.
            // The total cost up to i-1 was prevAdd. Then subtract nums[i].
            currSub = prevAdd - nums[i];

            // Update prev states for the next iteration
            prevAdd = currAdd;
            prevSub = currSub;
        }

        // The final answer is the maximum of the two possibilities for the last element:
        // either it was added or it was subtracted.
        return Math.max(prevAdd, prevSub);
    }
}