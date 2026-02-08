#include <stack>
#include <string>

using namespace std;

class Solution {
public:
    int calculate(string s) {
        stack<int> nums;
        stack<char> ops;
        int num = 0;
        int sign = 1;
        int res = 0;
        nums.push(1);

        for (char c : s) {
            if (isdigit(c)) {
                num = num * 10 + (c - '0');
            } else if (c == '+') {
                res += nums.top() * sign * num;
                num = 0;
                sign = 1;
            } else if (c == '-') {
                res += nums.top() * sign * num;
                num = 0;
                sign = -1;
            } else if (c == '(') {
                nums.push(nums.top() * sign);
                res += nums.top() * sign * num;
                num = 0;
                sign = 1;
                res = 0;

            } else if (c == ')') {
                res += nums.top() * sign * num;
                num = 0;
                nums.pop();
                sign = 1;
            }
        }
        res += nums.top() * sign * num;
        return res;
    }
};