class Solution {
public:
    vector<int> diffWaysToCompute(string expression) {
        if (memo.count(expression)) {
            return memo[expression];
        }

        vector<int> results;
        for (int i = 0; i < expression.length(); ++i) {
            char c = expression[i];
            if (c == '+' || c == '-' || c == '*') {
                string left_str = expression.substr(0, i);
                string right_str = expression.substr(i + 1);

                vector<int> left_results = diffWaysToCompute(left_str);
                vector<int> right_results = diffWaysToCompute(right_str);

                for (int l : left_results) {
                    for (int r : right_results) {
                        if (c == '+') {
                            results.push_back(l + r);
                        } else if (c == '-') {
                            results.push_back(l - r);
                        } else {
                            results.push_back(l * r);
                        }
                    }
                }
            }
        }

        if (results.empty()) {
            results.push_back(stoi(expression));
        }

        return memo[expression] = results;
    }

private:
    unordered_map<string, vector<int>> memo;
};