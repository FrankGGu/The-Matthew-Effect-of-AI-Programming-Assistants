class Solution {
public:
    long long minimumSteps(string s) {
        long long res = 0;
        int white = 0;
        for (char c : s) {
            if (c == '0') {
                white++;
            } else {
                res += white;
            }
        }
        return res;
    }
};