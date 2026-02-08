class Solution {
    public int numTeams(int[] rating) {
        int n = rating.length;
        if (n < 3) {
            return 0;
        }

        int teams = 0;

        // Iterate through j, the middle element of the triplet
        for (int j = 1; j < n - 1; j++) {
            int currentRating = rating[j];
            int leftSmaller = 0;
            int leftLarger = 0;
            int rightSmaller = 0;
            int rightLarger = 0;

            // Count elements to the left of j
            for (int i = 0; i < j; i++) {
                if (rating[i] < currentRating) {
                    leftSmaller++;
                } else { // rating[i] > currentRating because all ratings are unique
                    leftLarger++;
                }
            }

            // Count elements to the right of j
            for (int k = j + 1; k < n; k++) {
                if (rating[k] < currentRating) {
                    rightSmaller++;
                } else { // rating[k] > currentRating
                    rightLarger++;
                }
            }

            // For increasing sequence: rating[i] < rating[j] < rating[k]
            // Number of ways to choose 'i' is leftSmaller
            // Number of ways to choose 'k' is rightLarger
            teams += leftSmaller * rightLarger;

            // For decreasing sequence: rating[i] > rating[j] > rating[k]
            // Number of ways to choose 'i' is leftLarger
            // Number of ways to choose 'k' is rightSmaller
            teams += leftLarger * rightSmaller;
        }

        return teams;
    }
}