class Solution {
public:
    bool checkRecord(std::string s) {
        int absentCount = 0;
        int consecutiveLateCount = 0;

        for (char c : s) {
            if (c == 'A') {
                absentCount++;
                consecutiveLateCount = 0;
                if (absentCount > 1) {
                    return false;
                }
            } else if (c == 'L') {
                consecutiveLateCount++;
                if (consecutiveLateCount >= 3) {
                    return false;
                }
            } else { // c == 'P'
                consecutiveLateCount = 0;
            }
        }

        return true;
    }
};