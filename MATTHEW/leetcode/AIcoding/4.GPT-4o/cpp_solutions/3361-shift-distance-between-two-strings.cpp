class Solution {
public:
    int shiftDistance(string s, string goal) {
        if (s.size() != goal.size()) return -1;
        int n = s.size();
        for (int shift = 0; shift < n; ++shift) {
            string shifted = s.substr(shift) + s.substr(0, shift);
            if (shifted == goal) return shift;
        }
        return -1;
    }
};