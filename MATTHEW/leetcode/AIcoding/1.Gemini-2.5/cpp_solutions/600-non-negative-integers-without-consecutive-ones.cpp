#include <vector>

class Solution {
public:
    int findIntegers(int n) {
        std::vector<int> fib(31);
        fib[0] = 1;
        fib[1] = 2;
        for (int i = 2; i < 31; ++i) {
            fib[i] = fib[i-1] + fib[i-2];
        }

        int ans = 0;
        bool prev_is_one = false;
        for (int i = 30; i >= 0; --i) {
            if ((n >> i) & 1) { // If the i-th bit of n is 1
                ans += fib[i];
                if (prev_is_one) {
                    // Current bit is 1, and the previous bit was also 1.
                    // This means 'n' itself contains consecutive ones.
                    // All numbers with this prefix (which is 'n' up to this point) are invalid.
                    // We have already counted all valid numbers strictly less than 'n'.
                    // So we return the current 'ans'.
                    return ans;
                }
                prev_is_one = true;
            } else { // If the i-th bit of n is 0
                prev_is_one = false;
            }
        }

        // If the loop finishes without returning, it means 'n' itself does not contain consecutive ones.
        // In this case, 'n' should be included in the count.
        ans++; 
        return ans;
    }
};