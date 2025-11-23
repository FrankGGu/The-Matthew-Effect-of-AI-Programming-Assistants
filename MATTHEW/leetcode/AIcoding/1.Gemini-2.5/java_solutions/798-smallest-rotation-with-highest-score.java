class Solution {
    public int bestRotation(int[] nums) {
        int n = nums.length;
        int[] diff = new int[n]; // diff[k] represents score[k] - score[k-1]

        // Calculate initial score for k=0 and populate diff array
        int currentScore = 0;
        for (int j = 0; j < n; j++) {
            // For k=0, nums[j] is at index j. It contributes if nums[j] <= j.
            if (nums[j] <= j) {
                currentScore++;
            }

            // Event 1: nums[j] stops contributing.
            // An element nums[j] at original index j moves to position (j - k + N) % N after rotation k.
            // It contributes if nums[j] <= (j - k + N) % N.
            // It stops contributing when its position drops from nums[j] to nums[j]-1.
            // The rotation k where nums[j] is at position nums[j] is k_val_at_pos = (j - nums[j] + N) % N.
            // For rotation k_val_at_pos + 1, nums[j] moves to position nums[j]-1.
            // So, at rotation (k_val_at_pos + 1), the score decreases by 1.
            int kStopRotationIdx = (j - nums[j] + n) % n;
            if (kStopRotationIdx + 1 < n) {
                diff[kStopRotationIdx + 1]--;
            }

            // Event 2: nums[j] starts contributing again after wrapping around.
            // It starts contributing when its position (j - k + N) % N wraps from 0 to N-1.
            // The rotation k where nums[j] is at position 0 is k_pos_is_0 = (j - 0 + N) % N = j.
            // For rotation k_pos_is_0 + 1, nums[j] moves to position N-1.
            // Since nums[j] <= N-1 (always true for valid input values), it will contribute.
            // So, at rotation (k_pos_is_0 + 1), the score increases by 1.
            int kStartRotationIdx = j;
            if (kStartRotationIdx + 1 < n) {
                diff[kStartRotationIdx + 1]++;
            }
        }

        int maxScore = currentScore;
        int bestK = 0;

        // Calculate scores for k=1 to N-1 using the diff array
        for (int k = 1; k < n; k++) {
            currentScore += diff[k];
            if (currentScore > maxScore) {
                maxScore = currentScore;
                bestK = k;
            }
        }

        return bestK;
    }
}