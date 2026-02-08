#include <vector>
#include <string>
#include <algorithm> // For std::sort
#include <limits>    // For std::numeric_limits

class Solution {
private:
    // Static vector to store precomputed numerically balanced numbers.
    // This ensures the numbers are generated only once across multiple test cases.
    static std::vector<int> balanced_numbers_int;
    // Static flag to track if the numbers have been generated and sorted.
    static bool initialized;

    // Recursive helper function to generate numerically balanced numbers.
    // digit_idx: The current digit (from 1 to 9) being considered for inclusion.
    // current_length: The sum of digits chosen so far, which is also the total length of the number.
    // counts: A vector where counts[d] stores 'd' if digit 'd' is chosen to be in the number, otherwise 0.
    static void generate(int digit_idx, int current_length, std::vector<int>& counts) {
        // Pruning condition: If the current length exceeds 10, any number formed
        // will have more than 10 digits and thus exceed the maximum value for an int (approx 2 * 10^9).
        if (current_length > 10) {
            return;
        }

        // Base case: All digits from 1 to 9 have been considered.
        if (digit_idx == 10) {
            // If current_length is 0, no digits were chosen, so it's not a valid number.
            if (current_length == 0) {
                return;
            }

            // Construct the number string by appending each chosen digit 'd' for 'd' times.
            // The digits are appended in increasing order (1s, then 2s, etc.) to form the smallest number.
            std::string s = "";
            for (int d = 1; d <= 9; ++d) {
                for (int i = 0; i < counts[d]; ++i) {
                    s += (char)('0' + d);
                }
            }

            // Convert the string to a long long to safely check against INT_MAX.
            long long num_ll = std::stoll(s);

            // If the number fits within the int range, add it to our list.
            if (num_ll <= std::numeric_limits<int>::max()) {
                balanced_numbers_int.push_back((int)num_ll);
            }
            return;
        }

        // Recursive Step 1: Do not include the current digit_idx in the number.
        generate(digit_idx + 1, current_length, counts);

        // Recursive Step 2: Include the current digit_idx in the number (digit_idx times).
        counts[digit_idx] = digit_idx; // Mark digit_idx as chosen, with its count being digit_idx.
        generate(digit_idx + 1, current_length + digit_idx, counts);
        counts[digit_idx] = 0; // Backtrack: remove digit_idx for other combinations.
    }

public:
    int nextGreaterNumericallyBalanced(int n) {
        // Initialize balanced numbers only once.
        if (!initialized) {
            std::vector<int> counts(10, 0); // counts[d] will store d if digit d is chosen, 0 otherwise.
            generate(1, 0, counts); // Start generation from digit 1, with initial length 0.
            std::sort(balanced_numbers_int.begin(), balanced_numbers_int.end()); // Sort the generated numbers.
            initialized = true; // Set flag to true after initialization.
        }

        // Find the smallest numerically balanced number strictly greater than n.
        // Since balanced_numbers_int is sorted, the first number greater than n is the answer.
        for (int num : balanced_numbers_int) {
            if (num > n) {
                return num;
            }
        }

        // This line should theoretically not be reached given the problem constraints
        // (n <= 10^6, and there are always greater balanced numbers within int range).
        return -1; 
    }
};

std::vector<int> Solution::balanced_numbers_int;
bool Solution::initialized = false;