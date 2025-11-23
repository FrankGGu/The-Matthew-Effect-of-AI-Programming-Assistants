class Solution {
public:
    // This helper function defines what a "good integer" is.
    // As the problem description is empty, this implementation assumes
    // a "good integer" is one where all its digits are even.
    // This is a common type of "good integer" property in LeetCode problems.
    bool isGood(int n) {
        if (n == 0) {
            return true; // 0 is considered good (all its digits, which is just 0, are even).
        }
        int temp = n;
        while (temp > 0) {
            int digit = temp % 10;
            if (digit % 2 != 0) { // If any digit is odd, it's not good.
                return false;
            }
            temp /= 10;
        }
        return true; // All digits were even.
    }

    int countGoodIntegers(int low, int high) {
        int count = 0;
        for (int i = low; i <= high; ++i) {
            if (isGood(i)) {
                count++;
            }
        }
        return count;
    }
};