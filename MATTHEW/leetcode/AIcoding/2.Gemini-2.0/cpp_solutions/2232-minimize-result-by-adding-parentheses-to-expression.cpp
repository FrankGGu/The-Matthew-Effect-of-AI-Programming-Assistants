#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string minimizeResult(string expression) {
        int plus_pos = expression.find('+');
        int n = expression.size();
        int best_left = 0, best_right = n - 1;
        int min_val = INT_MAX;

        for (int left = 0; left < plus_pos; ++left) {
            for (int right = plus_pos + 1; right < n; ++right) {
                int left_val = 1;
                if (left > 0) {
                    left_val = stoi(expression.substr(0, left));
                }
                int right_val = 1;
                if (right < n - 1) {
                    right_val = stoi(expression.substr(right + 1));
                }
                int mid_val = stoi(expression.substr(left, plus_pos - left)) + stoi(expression.substr(plus_pos + 1, right - plus_pos));
                int current_val = left_val * mid_val * right_val;
                if (current_val < min_val) {
                    min_val = current_val;
                    best_left = left;
                    best_right = right;
                }
            }
        }

        string result = "";
        for (int i = 0; i < n; ++i) {
            if (i == best_left) {
                result += "(";
            }
            result += expression[i];
            if (i == best_right) {
                result += ")";
            }
        }

        return result;
    }
};