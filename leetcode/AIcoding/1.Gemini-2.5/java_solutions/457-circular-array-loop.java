class Solution {
    public boolean circularArrayLoop(int[] nums) {
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            if (nums[i] == 0) { // Already visited and determined not to lead to a valid cycle
                continue;
            }

            int slow = i;
            int fast = i;
            // Store the sign of the starting element. All elements in the cycle must have this sign.
            // Using 1 for positive, -1 for negative.
            int originalSign = nums[i] > 0 ? 1 : -1; 

            while (true) {
                slow = getNext(nums, slow, originalSign);
                if (slow == -1) {
                    break;
                }

                fast = getNext(nums, fast, originalSign);
                if (fast == -1) {
                    break;
                }

                fast = getNext(nums, fast, originalSign);
                if (fast == -1) {
                    break;
                }

                if (slow == fast) {
                    return true; // Cycle detected
                }
            }

            // If we reach here, no valid cycle found starting from i.
            // Mark all nodes in this path as 0 to avoid re-processing them.
            // We re-traverse from 'i' to mark the path.
            int curr = i;
            // The condition (nums[curr] > 0 == (originalSign > 0)) checks if nums[curr] still has the same direction as originalSign.
            // If nums[curr] is 0, (0 > 0) is false, so it will stop.
            while (curr != -1 && (nums[curr] > 0 == (originalSign > 0))) { 
                int next = getNext(nums, curr, originalSign); 
                nums[curr] = 0; // Mark as visited and invalid for future checks
                curr = next;
            }
        }

        return false;
    }

    // Helper function to get the next index
    private int getNext(int[] nums, int currentIdx, int originalSign) {
        int n = nums.length;
        int currentVal = nums[currentIdx];

        // Check for direction change relative to the originalSign
        // (currentVal > 0) != (originalSign > 0) checks if signs are different.
        // If signs are different, return -1.
        if ((currentVal > 0) != (originalSign > 0)) {
            return -1;
        }

        int nextIdx = (currentIdx + currentVal) % n;

        // Handle negative modulo result in Java
        if (nextIdx < 0) {
            nextIdx += n;
        }

        // Check for self-loop (cycle of length 1)
        // If currentIdx + currentVal results in currentIdx, it's a length 1 cycle.
        // This happens if currentVal is a multiple of n.
        if (nextIdx == currentIdx) {
            return -1;
        }

        return nextIdx;
    }
}