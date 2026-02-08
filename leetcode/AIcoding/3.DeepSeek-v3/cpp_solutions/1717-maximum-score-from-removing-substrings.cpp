class Solution {
public:
    int maximumGain(string s, int x, int y) {
        int a = 'a', b = 'b';
        if (x < y) {
            swap(a, b);
            swap(x, y);
        }
        int res = 0;
        stack<char> st1, st2;
        for (char c : s) {
            if (!st1.empty() && st1.top() == a && c == b) {
                st1.pop();
                res += x;
            } else {
                st1.push(c);
            }
        }
        while (!st1.empty()) {
            char c = st1.top();
            st1.pop();
            if (!st2.empty() && st2.top() == a && c == b) {
                st2.pop();
                res += y;
            } else {
                st2.push(c);
            }
        }
        return res;
    }
};