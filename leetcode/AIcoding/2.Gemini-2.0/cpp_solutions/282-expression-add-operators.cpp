#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> addOperators(string num, int target) {
        vector<string> result;
        if (num.empty()) return result;
        helper(result, "", num, target, 0, 0, 0);
        return result;
    }

private:
    void helper(vector<string>& result, string expr, string num, int target, int pos, long currentVal, long prevOperand) {
        if (pos == num.size()) {
            if (currentVal == target) {
                result.push_back(expr);
            }
            return;
        }

        for (int i = pos; i < num.size(); ++i) {
            if (i != pos && num[pos] == '0') break;
            string sub = num.substr(pos, i - pos + 1);
            long val = stol(sub);

            if (pos == 0) {
                helper(result, sub, num, target, i + 1, val, val);
            } else {
                helper(result, expr + "+" + sub, num, target, i + 1, currentVal + val, val);
                helper(result, expr + "-" + sub, num, target, i + 1, currentVal - val, -val);
                helper(result, expr + "*" + sub, num, target, i + 1, currentVal - prevOperand + prevOperand * val, prevOperand * val);
            }
        }
    }
};