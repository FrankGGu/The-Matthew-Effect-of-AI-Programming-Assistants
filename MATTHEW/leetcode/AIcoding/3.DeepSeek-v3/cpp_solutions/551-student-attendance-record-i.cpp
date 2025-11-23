class Solution {
public:
    bool checkRecord(string s) {
        int absent = 0;
        int late = 0;

        for (char c : s) {
            if (c == 'A') {
                absent++;
                late = 0;
                if (absent >= 2) {
                    return false;
                }
            } else if (c == 'L') {
                late++;
                if (late >= 3) {
                    return false;
                }
            } else {
                late = 0;
            }
        }

        return true;
    }
};