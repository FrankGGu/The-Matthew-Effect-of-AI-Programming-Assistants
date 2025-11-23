class Solution {
public:
    int maxPower(string s) {
        int maxPower = 1, currentPower = 1;
        for (int i = 1; i < s.size(); ++i) {
            if (s[i] == s[i - 1]) {
                currentPower++;
            } else {
                currentPower = 1;
            }
            maxPower = max(maxPower, currentPower);
        }
        return maxPower;
    }
};