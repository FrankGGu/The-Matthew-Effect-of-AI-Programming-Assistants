class Solution {
public:
    string countAndSay(int n) {
        if (n == 1) return "1";
        string prev = countAndSay(n - 1);
        string res;
        int count = 1;
        for (int i = 0; i < prev.size(); ++i) {
            if (i + 1 < prev.size() && prev[i] == prev[i + 1]) {
                ++count;
            } else {
                res += to_string(count) + prev[i];
                count = 1;
            }
        }
        return res;
    }
};