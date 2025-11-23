class Solution {
    public long minimumPossibleSum(int n, int target) {
        long sum = 0;
        // Calculate the count of numbers less than target/2.
        // These numbers (1, 2, ..., k where k < target/2) can always be picked
        // because their complements (target - x) would be greater than target/2,
        // and thus distinct from x and not yet considered.
        // (target - 1) / 2 gives floor(target/2) - 1 if target is even, and floor(target/2) if target is odd.
        // This is equivalent to k in the derivation (max value less than target/2).
        long countLessThanHalf = (target - 1) / 2; 

        if (n <= countLessThanHalf) {
            // If we need 'n' numbers and 'n' is less than or equal to countLessThanHalf,
            // we can simply pick the first 'n' positive integers: 1, 2, ..., n.
            // For any x, y in {1, ..., n}, x + y <= n + (n-1) = 2n - 1.
            // Since n <= countLessThanHalf, 2n <= 2 * (target - 1) / 2 = target - 1.
            // So, 2n - 1 < target. Thus, x + y will never equal target.
            sum = (long) n * (n + 1) / 2;
        } else {
            // We pick all numbers from 1 up to countLessThanHalf.
            // These are 'countLessThanHalf' numbers.
            sum = countLessThanHalf * (countLessThanHalf + 1) / 2;

            // We still need to pick 'n - countLessThanHalf' more numbers.
            long remainingN = n - countLessThanHalf;

            // The numbers from 1 to countLessThanHalf have been picked.
            // Their complements (target - x) are forbidden.
            // These forbidden numbers are (target - countLessThanHalf) to (target - 1).
            // (target - countLessThanHalf) is (target - (target-1)/2) = (target+1)/2.
            // So, numbers from (target+1)/2 up to (target-1) are forbidden.
            // The smallest positive integer not yet picked and not forbidden is 'target'.
            // We will pick 'target', 'target + 1', ..., 'target + remainingN - 1'.
            // Picking these numbers won't cause conflicts:
            // - With previously picked numbers (1 to countLessThanHalf):
            //   If target + i + x = target for some x in {1, ..., countLessThanHalf}, then target + i = target - x.
            //   This implies i = -x, which is impossible since i >= 0 and x > 0.
            // - Among themselves:
            //   If (target + i) + (target + j) = target for i != j, then target + i + j = 0, impossible.
            long firstValForRemaining = target;

            // Sum of an arithmetic progression: remainingN * firstTerm + (0 + 1 + ... + remainingN - 1)
            sum += remainingN * firstValForRemaining + (remainingN - 1) * remainingN / 2;
        }

        return sum;
    }
}