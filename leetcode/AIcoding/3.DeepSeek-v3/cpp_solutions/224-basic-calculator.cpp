class Solution {
public:
    int calculate(string s) {
        stack<int> nums;
        stack<int> ops;
        int num = 0;
        int result = 0;
        int sign = 1;

        for (char c : s) {
            if (isdigit(c)) {
                num = num * 10 + (c - '0');
            } else {
                result += sign * num;
                num = 0;
                if (c == '+') sign = 1;
                else if (c == '-') sign = -1;
                else if (c == '(') {
                    nums.push(result);
                    ops.push(sign);
                    result = 0;
                    sign = 1;
                } else if (c == ')' && !ops.empty()) {
                    result = nums.top() + ops.top() * result;
                    nums.pop();
                    ops.pop();
                }
            }
        }
        result += sign * num;
        return result;
    }
};