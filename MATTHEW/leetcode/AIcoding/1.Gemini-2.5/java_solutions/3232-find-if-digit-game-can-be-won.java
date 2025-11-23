class Solution {
    private int getDigits(int num) {
        if (num < 10) return 1;
        if (num < 100) return 2;
        if (num < 1000) return 3;
        if (num < 10000) return 4;
        if (num < 100000) return 5;
        if (num < 1000000) return 6;
        if (num < 10000000) return 7;
        if (num < 100000000) return 8;
        if (num < 1000000000) return 9;
        return 10;
    }

    public boolean canAliceWin(int[] nums1, int[] nums2) {
        int[] digitCounts1 = new int[11];
        int[] digitCounts2 = new int[11];

        for (int num : nums1) {
            digitCounts1[getDigits(num)]++;
        }
        for (int num : nums2) {
            digitCounts2[getDigits(num)]++;
        }

        int p1Score = 0;
        int p2Score = 0;

        int p1StrongerCount = 0; // Numbers from nums1 that are currently stronger than any nums2 numbers of this digit count or higher.
        int p2StrongerCount = 0; // Numbers from nums2 that are currently stronger than any nums1 numbers of this digit count or higher.

        // Iterate from the highest possible digit count down to the lowest.
        // This simulates players using their strongest available numbers first.
        for (int d = 10; d >= 1; d--) {
            // Add current digit 'd' numbers to the pool of stronger numbers.
            p1StrongerCount += digitCounts1[d];
            p2StrongerCount += digitCounts2[d];

            // Determine how many matches can be neutralized at this digit level or higher.
            // These are matches between numbers of comparable strength (d digits or more)
            // that won't result in points for either player based on this digit comparison.
            int neutralMatches = Math.min(p1StrongerCount, p2StrongerCount);

            p1StrongerCount -= neutralMatches;
            p2StrongerCount -= neutralMatches;

            // The remaining 'p1StrongerCount' numbers from nums1 are now definitively stronger
            // than any remaining numbers in nums2 that have 'd' or more digits.
            // These 'p1StrongerCount' numbers will be matched against nums2 numbers with fewer than 'd' digits,
            // thus scoring points for Player 1.
            p1Score += p1StrongerCount;

            // Similarly for Player 2.
            p2Score += p2StrongerCount;

            // Reset counts for the next iteration.
            // The numbers that contributed to p1Score/p2Score are considered "used" for scoring.
            p1StrongerCount = 0;
            p2StrongerCount = 0;
        }

        return p1Score > p2Score;
    }
}