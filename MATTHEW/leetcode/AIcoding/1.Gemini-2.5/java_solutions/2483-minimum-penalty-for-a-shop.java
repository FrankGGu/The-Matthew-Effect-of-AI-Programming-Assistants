class Solution {
    public int bestClosingTime(String customers) {
        int n = customers.length();

        // Calculate the initial penalty for closing hour j = 0.
        // If the shop closes at hour 0, all customers from index 0 to n-1 are "after closing".
        // A 'Y' customer after closing contributes 1 to penalty.
        int currentPenalty = 0;
        for (int i = 0; i < n; i++) {
            if (customers.charAt(i) == 'Y') {
                currentPenalty++;
            }
        }

        int minPenalty = currentPenalty;
        int minHour = 0;

        // Iterate through possible closing hours from j=1 to j=n.
        // We simulate moving the closing hour one step at a time.
        // When moving from closing hour `j` to `j+1`, we consider the customer at index `j`.
        // This customer moves from the "after closing" segment to the "before closing" segment.
        for (int j = 0; j < n; j++) {
            if (customers.charAt(j) == 'Y') {
                // If the customer at index `j` was 'Y':
                // It was in the "after closing" segment and contributed 1 to penalty.
                // Now it's in the "before closing" segment and does not contribute to penalty.
                // So, the total penalty decreases by 1.
                currentPenalty--;
            } else { // customers.charAt(j) == 'N'
                // If the customer at index `j` was 'N':
                // It was in the "after closing" segment and did not contribute to penalty.
                // Now it's in the "before closing" segment and contributes 1 to penalty.
                // So, the total penalty increases by 1.
                currentPenalty++;
            }

            // `currentPenalty` now represents the penalty for closing hour `j+1`.
            // Compare it with the minimum penalty found so far.
            if (currentPenalty < minPenalty) {
                minPenalty = currentPenalty;
                minHour = j + 1; // The current closing hour being evaluated is `j+1`.
            }
        }

        return minHour;
    }
}