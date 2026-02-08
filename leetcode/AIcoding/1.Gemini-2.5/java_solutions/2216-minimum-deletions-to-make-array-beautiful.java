class Solution {
    public int minDeletions(int[] nums) {
        int keptCount = 0;
        int deletions = 0;
        int lastKeptVal = -1; 

        for (int num : nums) {
            if (keptCount % 2 == 0) {
                // We are looking for the first element of a new pair.
                // We always keep this element to maximize the kept elements.
                lastKeptVal = num;
                keptCount++;
            } else {
                // We are looking for the second element of the current pair.
                // It must be different from the last kept element.
                if (num != lastKeptVal) {
                    keptCount++;
                } else {
                    // If it's the same, we must delete it as it violates the condition.
                    deletions++;
                }
            }
        }

        // After processing all elements, if the number of kept elements is odd,
        // we must delete the last one to make the total length even.
        if (keptCount % 2 != 0) {
            deletions++;
        }

        return deletions;
    }
}