#include <string>
#include <map>
#include <stack>
#include <cctype>

class Solution {
public:
    std::string countOfAtoms(std::string formula) {
        std::map<std::string, int> finalCounts;
        std::stack<std::map<std::string, int>> stack;

        int n = formula.length();
        int i = 0;

        while (i < n) {
            if (formula[i] == '(') {
                stack.push(finalCounts);
                finalCounts = {};
                i++;
            } else if (formula[i] == ')') {
                i++;
                int multiplier = 0;
                while (i < n && std::isdigit(formula[i])) {
                    multiplier = multiplier * 10 + (formula[i] - '0');
                    i++;
                }
                if (multiplier == 0) multiplier = 1;

                if (!stack.empty()) {
                    std::map<std::string, int> prevCounts = stack.top();
                    stack.pop();

                    for (auto const& [atom, count] : finalCounts) {
                        prevCounts[atom] += count * multiplier;
                    }
                    finalCounts = prevCounts;
                }
            } else {
                std::string atomName;
                atomName += formula[i];
                i++;
                while (i < n && std::islower(formula[i])) {
                    atomName += formula[i];
                    i++;
                }

                int count = 0;
                while (i < n && std::isdigit(formula[i])) {
                    count = count * 10 + (formula[i] - '0');
                    i++;
                }
                if (count == 0) count = 1;

                finalCounts[atomName] += count;
            }
        }

        std::string result = "";
        for (auto const& [atom, count] : finalCounts) {
            result += atom;
            if (count > 1) {
                result += std::to_string(count);
            }
        }
        return result;
    }
};