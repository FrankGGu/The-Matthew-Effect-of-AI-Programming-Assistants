class Solution {
    public boolean makesquare(int[] matchsticks) {
        if (matchsticks == null || matchsticks.length < 4) {
            return false;
        }

        int totalSum = 0;
        for (int matchstick : matchsticks) {
            totalSum += matchstick;
        }

        if (totalSum % 4 != 0) {
            return false;
        }

        int targetSideLength = totalSum / 4;

        // Sort matchsticks in descending order to try larger ones first
        // This can lead to earlier pruning of branches that won't work.
        Integer[] nums = new Integer[matchsticks.length];
        for (int i = 0; i < matchsticks.length; i++) {
            nums[i] = matchsticks[i];
        }
        Arrays.sort(nums, (a, b) -> b - a);

        // If any matchstick is longer than the target side length, it's impossible
        if (nums[0] > targetSideLength) {
            return false;
        }

        int[] sides = new int[4]; // Represents the current sum for each of the four sides

        return backtrack(nums, 0, sides, targetSideLength);
    }

    private boolean backtrack(Integer[] matchsticks, int index, int[] sides, int targetSideLength) {
        if (index == matchsticks.length) {
            // All matchsticks have been placed.
            // Check if all four sides have the target length.
            // This check is actually redundant if the sum logic is correct,
            // as we only proceed if a matchstick fits.
            // But it serves as a final confirmation.
            return sides[0] == targetSideLength &&
                   sides[1] == targetSideLength &&
                   sides[2] == targetSideLength &&
                   sides[3] == targetSideLength;
        }

        for (int i = 0; i < 4; i++) {
            if (sides[i] + matchsticks[index] <= targetSideLength) {
                sides[i] += matchsticks[index];
                if (backtrack(matchsticks, index + 1, sides, targetSideLength)) {
                    return true;
                }
                sides[i] -= matchsticks[index]; // Backtrack: remove the matchstick
            }
        }
        return false;
    }
}