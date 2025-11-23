class Solution {
    public long countPairs(int[] hours) {
        long count = 0;
        int[] remainders = new int[24]; // Stores frequency of remainders when divided by 24

        for (int hour : hours) {
            int remainder = hour % 24;

            // If current remainder is 0, it needs to pair with another 0.
            // If current remainder is X (not 0), it needs to pair with (24 - X).
            // Example: 12 needs to pair with 12. 5 needs to pair with 19.
            if (remainder == 0) {
                count += remainders[0];
            } else {
                // For any non-zero remainder, find its complement to sum up to 24.
                // E.g., if remainder is 5, complement is 19. If remainder is 12, complement is 12.
                count += remainders[24 - remainder];
            }

            // Increment the frequency of the current remainder
            remainders[remainder]++;
        }

        return count;
    }
}