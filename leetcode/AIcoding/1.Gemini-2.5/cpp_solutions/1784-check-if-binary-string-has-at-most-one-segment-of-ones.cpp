class Solution {
public:
    bool checkOnesSegment(string s) {
        bool oneSegmentEnded = false;
        for (char c : s) {
            if (c == '0') {
                oneSegmentEnded = true;
            } else if (oneSegmentEnded) {
                return false;
            }
        }
        return true;
    }
};