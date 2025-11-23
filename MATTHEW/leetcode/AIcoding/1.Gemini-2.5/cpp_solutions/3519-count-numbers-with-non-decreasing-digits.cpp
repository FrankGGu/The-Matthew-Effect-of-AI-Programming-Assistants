class Solution {
public:
    long long combinations(int n, int k) {
        if (k < 0 || k > n) {
            return 0;
        }
        if (k == 0 || k == n) {
            return 1;
        }
        // Optimize by choosing the smaller k for calculation: C(n, k) = C(n, n-k)
        if (k > n / 2) {
            k = n - k;
        }

        long long res = 1;
        for (int i = 1; i <= k; ++i) {
            res = res * (n - i + 1) / i;
        }
        return res;
    }

    int countNumbersWithNonDecreasingDigits(int n) {
        // The problem asks to count numbers 'x' such that 0 <= x < 10^n
        // and 'x' has non-decreasing digits.
        // This is equivalent to counting non-decreasing sequences of length 'n'
        // using digits 0-9. For example, if n=2, we count sequences like 00, 01, ..., 09, 11, ..., 99.
        // The sequence '00' represents the number 0, '01' represents 1, etc.
        // All such sequences, when interpreted as numbers, are unique and satisfy the condition.

        // This is a classic combinatorics problem that can be solved using "stars and bars".
        // We are choosing 'n' digits from 10 possible digits (0-9) with replacement,
        // and the order of selection doesn't matter because we arrange them in non-decreasing order.
        // The formula for choosing 'k' items from 'm' types with replacement is C(m + k - 1, k).
        // Here, 'm' (number of types of digits) = 10 (digits 0-9).
        // And 'k' (number of items/digits in the sequence) = n.
        // So, the count is C(10 + n - 1, n) = C(n + 9, n).
        // Using the identity C(N, K) = C(N, N-K), we can also write this as C(n + 9, (n + 9) - n) = C(n + 9, 9).

        // Example: n=1
        // Count numbers 0 <= x < 10. Non-decreasing numbers are 0, 1, 2, 3, 4, 5, 6, 7, 8, 9. Total 10.
        // Formula: C(1 + 9, 9) = C(10, 9) = 10. Correct.

        // Example: n=2
        // Count numbers 0 <= x < 100. Non-decreasing numbers:
        // 0-9 (10 numbers)
        // 11, 12, ..., 19 (9 numbers)
        // 22, 23, ..., 29 (8 numbers)
        // ...
        // 99 (1 number)
        // Total = 10 + (9 + 8 + ... + 1) = 10 + 45 = 55.
        // Formula: C(2 + 9, 9) = C(11, 9) = C(11, 2) = (11 * 10) / (2 * 1) = 55. Correct.

        // The result for n up to 10 (C(19, 9) = 92378) fits within an int.
        return static_cast<int>(combinations(n + 9, 9));
    }
};