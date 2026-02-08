class Solution {
    public int frogJumpII(int[] stones) {
        int n = stones.length;

        if (n <= 2) {
            return stones[n - 1] - stones[0];
        }

        int maxCost = 0;
        // The maximum jump will be either a direct jump between adjacent stones
        // or a jump that skips one intermediate stone.
        // A jump skipping more than one stone can always be broken down into
        // smaller jumps (either direct or skipping one) without increasing the maximum cost.
        // Specifically, if a path jumps from stones[i] to stones[j] where j > i+1,
        // all intermediate stones stones[i+1], ..., stones[j-1] must be visited by the other path.
        // The maximum jump will be stones[j] - stones[i].
        // This value is always greater than or equal to stones[k+2] - stones[k] for k in [i, j-2].
        // Thus, the overall maximum jump will be determined by the maximum of stones[i+2] - stones[i].
        for (int i = 0; i < n - 2; i++) {
            maxCost = Math.max(maxCost, stones[i + 2] - stones[i]);
        }

        return maxCost;
    }
}