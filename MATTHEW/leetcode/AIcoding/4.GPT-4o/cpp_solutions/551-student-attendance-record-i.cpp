class Solution {
public:
    bool checkRecord(string s) {
        int aCount = 0, lCount = 0;
        for (char c : s) {
            if (c == 'A') aCount++;
            if (c == 'L') lCount++;
            if (lCount > 2) return false;
        }
        return aCount < 2;
    }
};