class Solution {
    public int minimumOperations(String num) {
        int n = num.length();
        int minOps = Integer.MAX_VALUE;

        // Try to make it end with "00"
        minOps = Math.min(minOps, calculateDeletions(num, '0', '0'));

        // Try to make it end with "25"
        minOps = Math.min(minOps, calculateDeletions(num, '2', '5'));

        // Try to make it end with "50"
        minOps = Math.min(minOps, calculateDeletions(num, '5', '0'));

        // Try to make it end with "75"
        minOps = Math.min(minOps, calculateDeletions(num, '7', '5'));

        // Consider the case where the number becomes '0'.
        // '0' is divisible by 25, so it's a special number.
        // This requires finding at least one '0' and deleting all other digits.
        boolean hasZero = false;
        for (char c : num.toCharArray()) {
            if (c == '0') {
                hasZero = true;
                break;
            }
        }
        if (hasZero) {
            minOps = Math.min(minOps, n - 1);
        }

        return minOps;
    }

    private int calculateDeletions(String s, char targetX, char targetY) {
        int n = s.length();
        int idxY = -1;
        int idxX = -1;
        boolean foundY = false;

        // Find the rightmost targetY
        // Then find the rightmost targetX to its left
        for (int i = n - 1; i >= 0; i--) {
            char currentChar = s.charAt(i);
            if (!foundY && currentChar == targetY) {
                idxY = i;
                foundY = true;
            } else if (foundY && currentChar == targetX) {
                idxX = i;
                break; // Found targetX to the left of targetY
            }
        }

        if (idxX != -1 && idxY != -1) {
            // Deletions after targetY: (n - 1 - idxY)
            // Deletions between targetX and targetY: (idxY - 1 - idxX)
            return (n - 1 - idxY) + (idxY - 1 - idxX);
        } else {
            return Integer.MAX_VALUE; // Cannot form this pair
        }
    }
}