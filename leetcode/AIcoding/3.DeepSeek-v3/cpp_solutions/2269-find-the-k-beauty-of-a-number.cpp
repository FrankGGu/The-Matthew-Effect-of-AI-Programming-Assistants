class Solution {
public:
    int divisorSubstrings(int num, int k) {
        string s = to_string(num);
        int n = s.size();
        int res = 0;
        for (int i = 0; i <= n - k; ++i) {
            string sub = s.substr(i, k);
            int x = stoi(sub);
            if (x != 0 && num % x == 0) {
                ++res;
            }
        }
        return res;
    }
};