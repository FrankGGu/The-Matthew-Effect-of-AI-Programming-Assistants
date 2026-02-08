#include <string>
#include <map>
#include <stack>
#include <cctype>
#include <algorithm>

class Solution {
public:
    std::string countOfAtoms(std::string formula) {
        std::map<std::string, int> atomCount;
        std::stack<std::map<std::string, int>> stk;
        int n = formula.size();
        for (int i = 0; i < n; ++i) {
            if (isupper(formula[i])) {
                std::string atom(1, formula[i]);
                ++i;
                while (i < n && islower(formula[i])) {
                    atom += formula[i++];
                }
                int count = 0;
                while (i < n && isdigit(formula[i])) {
                    count = count * 10 + (formula[i++] - '0');
                }
                if (count == 0) count = 1;
                atomCount[atom] += count;
                --i;
            } else if (formula[i] == '(') {
                stk.push(atomCount);
            } else if (formula[i] == ')') {
                ++i;
                int count = 0;
                while (i < n && isdigit(formula[i])) {
                    count = count * 10 + (formula[i++] - '0');
                }
                if (count == 0) count = 1;
                for (auto& entry : atomCount) {
                    entry.second *= count;
                }
                if (!stk.empty()) {
                    auto top = stk.top();
                    stk.pop();
                    for (auto& entry : atomCount) {
                        top[entry.first] += entry.second;
                    }
                    atomCount = top;
                }
                --i;
            }
        }
        std::string result;
        std::vector<std::pair<std::string, int>> sortedAtoms(atomCount.begin(), atomCount.end());
        std::sort(sortedAtoms.begin(), sortedAtoms.end());
        for (const auto& entry : sortedAtoms) {
            result += entry.first;
            if (entry.second > 1) {
                result += std::to_string(entry.second);
            }
        }
        return result;
    }
};