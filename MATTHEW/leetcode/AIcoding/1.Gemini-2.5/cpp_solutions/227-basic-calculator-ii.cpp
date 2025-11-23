#include <string>
#include <stack>
#include <cctype> // For isdigit

class Solution {
public:
    int calculate(std::string s) {
        std::stack<long long> nums;
        long long currentNum = 0;
        char op = '+'; // The operator *before* currentNum

        for (int i = 0; i < s.length(); ++i) {
            if (std::isdigit(s[i])) {
                currentNum = currentNum * 10 + (s[i] - '0');
            }

            // This condition triggers processing of currentNum with the 'op' that preceded it.
            // It activates when an operator is found, or at the very end of the string (if not a space).
            if ((!std::isdigit(s[i]) && s[i] != ' ') || i == s.length() - 1) {
                if (op == '+') {
                    nums.push(currentNum);
                } else if (op == '-') {
                    nums.push(-currentNum);
                } else if (op == '*') {
                    long long prev = nums.top();
                    nums.pop();
                    nums.push(prev * currentNum);
                } else if (op == '/') {
                    long long prev = nums.top();
                    nums.pop();
                    nums.push(prev / currentNum);
                }

                // Update the operator for the *next* number, if s[i] is an actual operator
                if (!std::isdigit(s[i]) && s[i] != ' ') {
                    op = s[i];
                }
                currentNum = 0; // Reset currentNum for the next number
            }
        }

        long long totalSum = 0;
        while (!nums.empty()) {
            totalSum += nums.top();
            nums.pop();
        }

        return static_cast<int>(totalSum);
    }
};