#include <vector>
#include <numeric> // Required for std::accumulate if used, but a manual loop is also fine.

class Solution {
public:
    int clumsy(int n) {
        // Using a vector as a stack to handle operator precedence.
        // Multiply and Divide operations are performed immediately on the last number pushed.
        // Add and Subtract operations push the number (or its negative) onto the stack.
        // Finally, all numbers in the stack are summed to get the result.

        std::vector<int> nums_stack;
        nums_stack.push_back(n); // Start with the first number 'n'

        int op_type = 0; // 0: *, 1: /, 2: +, 3: - (cyclical pattern)

        for (int i = n - 1; i >= 1; --i) {
            if (op_type % 4 == 0) { // Current operation is Multiply
                int top_val = nums_stack.back();
                nums_stack.pop_back();
                nums_stack.push_back(top_val * i);
            } else if (op_type % 4 == 1) { // Current operation is Divide
                int top_val = nums_stack.back();
                nums_stack.pop_back();
                nums_stack.push_back(top_val / i);
            } else if (op_type % 4 == 2) { // Current operation is Add
                nums_stack.push_back(i);
            } else { // Current operation is Subtract (op_type % 4 == 3)
                nums_stack.push_back(-i); // Push negative for subtraction
            }
            op_type++; // Move to the next operation in the cycle
        }

        // Sum all numbers remaining in the stack
        int result = 0;
        for (int num : nums_stack) {
            result += num;
        }

        return result;
    }
};