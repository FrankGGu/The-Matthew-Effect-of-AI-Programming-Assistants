class Solution {
public:
    int lengthLongestPath(string input) {
        stack<int> stk;
        stk.push(0);
        int res = 0;
        int n = input.size();
        for (int i = 0; i < n; ++i) {
            int level = 0;
            while (i < n && input[i] == '\t') {
                ++level;
                ++i;
            }
            bool isFile = false;
            int len = 0;
            while (i < n && input[i] != '\n') {
                if (input[i] == '.') {
                    isFile = true;
                }
                ++len;
                ++i;
            }
            while (stk.size() > level + 1) {
                stk.pop();
            }
            int curr = stk.top() + len + (level > 0 ? 1 : 0);
            stk.push(curr);
            if (isFile) {
                res = max(res, curr);
            }
        }
        return res;
    }
};