import java.util.Arrays;

class Solution {
    public int maxSatisfaction(int[] satisfaction) {
        Arrays.sort(satisfaction);

        int n = satisfaction.length;
        int maxLikeTimeCoefficient = 0;
        int currentLikeTimeCoefficient = 0;
        int sumOfSatisfactions = 0;

        // Iterate from the largest satisfaction values to the smallest.
        // This simulates adding dishes one by one, starting with the most satisfying.
        // When a new dish (satisfaction[i]) is added, all previously chosen dishes'
        // time coefficients increase by 1, and the new dish gets a coefficient of 1.
        // The change in total like-time coefficient is satisfaction[i] + (sum of all previously chosen dishes).
        for (int i = n - 1; i >= 0; i--) {
            // The condition to continue adding dishes is that the sum of the current dish
            // and all dishes to its right (which are already part of `sumOfSatisfactions`)
            // must be positive. If this sum is negative or zero, it means including
            // this dish will reduce or keep the total like-time coefficient the same.
            // Since we are iterating from larger to smaller satisfaction values,
            // if adding the current dish does not improve the sum, no further smaller
            // dishes will improve it either.
            if (sumOfSatisfactions + satisfaction[i] > 0) {
                sumOfSatisfactions += satisfaction[i];
                currentLikeTimeCoefficient += sumOfSatisfactions;
                maxLikeTimeCoefficient = Math.max(maxLikeTimeCoefficient, currentLikeTimeCoefficient);
            } else {
                // If adding this dish would not increase the total like-time coefficient,
                // then we stop, as adding any smaller (or equal) satisfaction dishes
                // would also not increase it.
                break;
            }
        }

        return maxLikeTimeCoefficient;
    }
}