class Solution {
    public int maxScore(int[] cardPoints, int k) {
        int n = cardPoints.length;

        // Calculate the sum of the first k cards (representing taking all k cards from the left)
        int currentSum = 0;
        for (int i = 0; i < k; i++) {
            currentSum += cardPoints[i];
        }

        int maxScore = currentSum;

        // Iterate k times to consider all combinations of taking cards from left and right.
        // In each iteration, we remove one card from the left side of our current selection
        // and add one card from the right side of the original array.
        // This effectively slides the "window" of k chosen cards from being all left
        // to progressively including more cards from the right.
        for (int i = 0; i < k; i++) {
            // Remove the rightmost card from the current left selection
            // The index is k - 1 - i.
            // For i=0, it removes cardPoints[k-1].
            // For i=1, it removes cardPoints[k-2].
            // ...
            // For i=k-1, it removes cardPoints[0].
            currentSum -= cardPoints[k - 1 - i];

            // Add a card from the right end of the original array.
            // The index is n - 1 - i.
            // For i=0, it adds cardPoints[n-1].
            // For i=1, it adds cardPoints[n-2].
            // ...
            // For i=k-1, it adds cardPoints[n-k].
            currentSum += cardPoints[n - 1 - i];

            maxScore = Math.max(maxScore, currentSum);
        }

        return maxScore;
    }
}