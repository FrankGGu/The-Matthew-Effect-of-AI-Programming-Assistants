#include <string>
#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    bool checkDigitsAfterOperations(std::string s, int k) {
        // Perform operations until the string length is k or less
        while (s.length() > k) {
            std::string next_s = "";
            int n = s.length();

            // Iterate through the string in groups of k digits
            for (int i = 0; i < n; i += k) {
                int current_group_sum = 0;
                // Sum digits in the current group
                for (int j = 0; j < k && (i + j) < n; ++j) {
                    current_group_sum += (s[i + j] - '0');
                }
                // Convert the sum to a string and append it to next_s
                next_s += std::to_string(current_group_sum);
            }
            s = next_s; // Update s for the next iteration
        }

        // After operations, check if all digits in the final string s are equal
        if (s.empty()) {
            return true; // An empty string trivially has all digits equal
        }

        char first_digit = s[0];
        for (int i = 1; i < s.length(); ++i) {
            if (s[i] != first_digit) {
                return false; // Found a digit that is not equal to the first one
            }
        }
        return true; // All digits are equal
    }
};