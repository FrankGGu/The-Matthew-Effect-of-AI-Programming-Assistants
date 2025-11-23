class Solution {
public:
    string reverseDegree(string s) {
        int n = s.size();
        string result;
        for (int i = n - 1; i >= 0; --i) {
            result += s[i];
        }
        return result;
    }
};