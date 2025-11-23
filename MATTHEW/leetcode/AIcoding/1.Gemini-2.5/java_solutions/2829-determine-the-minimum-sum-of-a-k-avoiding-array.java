import java.util.HashSet;
import java.util.Set;

class Solution {
    public long minimumSum(int n, int k) {
        long sum = 0;

        // 'limit' represents k/2 (integer division).
        // Numbers from 1 to 'limit' can be picked without their 'k-complement' being a smaller number.
        // For example, if k=10, limit=5.
        // Picking 1 means we cannot pick 9. Picking 2 means we cannot pick 8, etc.
        // Picking 5 means we cannot pick 5 (but elements must be distinct anyway, so picking 5 once is fine).
        // To minimize sum, we always prefer picking the smaller number from a pair (x, k-x).
        // So, we prioritize picking 1, 2, ..., 'limit'.
        int limit = k / 2;

        // Case 1: We need to pick 'n' numbers, and 'n' is less than or equal to 'limit'.
        // In this case, we can simply pick 1, 2, ..., n.
        // No two distinct numbers x, y from this set will sum to k.
        // Because if x, y <= n <= limit, then x+y <= 2*limit.
        // If k is even, 2*limit = k. The only way x+y=k is if x=y=k/2. But x and y must be distinct.
        // If k is odd, 2*limit = k-1. So x+y <= k-1, thus x+y cannot be k.
        // So, picking 1, ..., n is always safe if n <= limit.
        if (n <= limit) {
            sum = (long) n * (n + 1) / 2;
            return sum;
        }

        // Case 2: We need to pick 'n' numbers, and 'n' is greater than 'limit'.
        // First, pick all numbers from 1 to 'limit'.
        // These are 'limit' numbers.
        sum = (long) limit * (limit + 1) / 2;
        int count = limit; // Number of elements picked so far

        // We still need to pick (n - count) more numbers.
        int remainingN = n - count;

        // The numbers from (limit + 1) up to (k - 1) are problematic.
        // For any number 'x' in this range, its complement 'k - x' will be in the range 1 to 'limit'.
        // Since we have already picked 1 to 'limit', these complements are already in our array.
        // Thus, we cannot pick any number from (limit + 1) to (k - 1).
        // The smallest available numbers that are not forbidden are k, k+1, k+2, ...

        // We need to pick 'remainingN' numbers starting from 'k'.
        // These numbers will be k, k+1, ..., k + remainingN - 1.
        // The sum of an arithmetic series is (number of terms / 2) * (first term + last term).
        // Number of terms = remainingN
        // First term = k
        // Last term = k + remainingN - 1
        long sumSecondPart = (long) remainingN * (2L * k + (remainingN - 1)) / 2;

        sum += sumSecondPart;

        return sum;
    }
}