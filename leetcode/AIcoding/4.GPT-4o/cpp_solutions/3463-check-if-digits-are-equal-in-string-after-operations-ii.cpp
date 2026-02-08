class Solution {
public:
    bool digitCount(string num) {
        vector<int> count(10, 0);
        int n = num.size();
        for (char c : num) {
            count[c - '0']++;
        }
        for (int i = 0; i < n; i++) {
            if (count[i] != num[i] - '0') {
                return false;
            }
        }
        return true;
    }
};