class Solution {
public:
    string decodeString(string s) {
        stack<string> chars;
        stack<int> nums;
        string res;
        int num = 0;
        for (char c : s) {
            if (isdigit(c)) {
                num = num * 10 + (c - '0');
            } else if (c == '[') {
                chars.push(res);
                nums.push(num);
                res = "";
                num = 0;
            } else if (c == ']') {
                string tmp = res;
                res = chars.top();
                chars.pop();
                int repeat = nums.top();
                nums.pop();
                while (repeat-- > 0) {
                    res += tmp;
                }
            } else {
                res += c;
            }
        }
        return res;
    }
};