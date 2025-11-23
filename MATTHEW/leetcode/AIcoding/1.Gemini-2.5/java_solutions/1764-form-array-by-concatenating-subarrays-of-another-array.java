class Solution {
    public boolean canChoose(int[][] groups, int[] nums) {
        int numsIdx = 0; // Current starting index in nums to search for the next group

        for (int i = 0; i < groups.length; i++) {
            int[] currentGroup = groups[i];

            // Search for currentGroup in nums starting from numsIdx
            int foundIdx = -1;

            // Iterate through possible starting positions in nums for currentGroup
            // The loop condition ensures there's enough space left in nums for currentGroup
            for (int j = numsIdx; j <= nums.length - currentGroup.length; j++) {
                boolean match = true;
                // Check if nums[j...j + currentGroup.length - 1] matches currentGroup
                for (int k = 0; k < currentGroup.length; k++) {
                    if (nums[j + k] != currentGroup[k]) {
                        match = false;
                        break;
                    }
                }

                if (match) {
                    foundIdx = j; // Found a match starting at index j
                    break; // Found the first occurrence, move to the next group
                }
            }

            if (foundIdx == -1) {
                // Current group not found in nums from numsIdx onwards
                return false;
            } else {
                // Update numsIdx to the position immediately after the found group
                numsIdx = foundIdx + currentGroup.length;
            }
        }

        // All groups were found in order and non-overlapping
        return true;
    }
}