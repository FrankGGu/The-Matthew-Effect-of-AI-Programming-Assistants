class Solution {
public:
    long long appealSum(string s) {
        long long res = 0;
        vector<int> lastPos(26, -1);
        for (int i = 0; i < s.size(); ++i) {
            int c = s[i] - 'a';
            res += (i - lastPos[c]) * (s.size() - i);
            lastPos[c] = i;
        }
        return res;
    }
};