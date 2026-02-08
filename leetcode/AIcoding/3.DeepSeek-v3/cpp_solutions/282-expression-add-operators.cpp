class Solution {
public:
    vector<string> addOperators(string num, int target) {
        vector<string> result;
        backtrack(num, target, 0, 0, 0, "", result);
        return result;
    }

private:
    void backtrack(const string& num, int target, int index, long value, long prev, string expr, vector<string>& result) {
        if (index == num.size()) {
            if (value == target) {
                result.push_back(expr);
            }
            return;
        }

        for (int i = index; i < num.size(); ++i) {
            if (i != index && num[index] == '0') {
                break;
            }

            string currentStr = num.substr(index, i - index + 1);
            long current = stol(currentStr);

            if (index == 0) {
                backtrack(num, target, i + 1, current, current, currentStr, result);
            } else {
                backtrack(num, target, i + 1, value + current, current, expr + "+" + currentStr, result);
                backtrack(num, target, i + 1, value - current, -current, expr + "-" + currentStr, result);
                backtrack(num, target, i + 1, value - prev + prev * current, prev * current, expr + "*" + currentStr, result);
            }
        }
    }
};