#include <string>

class Solution {
public:
    int minOperations(std::string s, int k) {
        int operations = 0;
        int left = 0;
        int right = s.length() - 1;

        while (right - left + 1 >= 2 * k) {
            // Compare the prefix s[left...left+k-1] with the suffix s[right-k+1...right]
            // std::string::compare returns 0 if the substrings are equal.
            if (s.compare(left, k, s, right - k + 1, k) == 0) {
                // If they are equal, remove both by adjusting the pointers
                left += k;
                right -= k;
                operations++;
            } else {
                // If the current prefix and suffix of length k do not match,
                // no more operations of this type can be performed on the remaining string.
                break;
            }
        }

        // If there are any characters left in the string (i.e., right - left + 1 > 0),
        // they must be removed in one final operation.
        if (right - left + 1 > 0) {
            operations++;
        }

        return operations;
    }
};