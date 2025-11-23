class Solution {
public:
    string shiftingLetters(string s, vector<vector<int>>& shifts) {
        vector<int> shift(s.size(), 0);
        for (auto& shiftInfo : shifts) {
            int start = shiftInfo[0], end = shiftInfo[1], direction = shiftInfo[2];
            shift[start] += (direction == 1) ? 1 : -1;
            if (end + 1 < s.size()) {
                shift[end + 1] += (direction == 1) ? -1 : 1;
            }
        }

        int currentShift = 0;
        for (int i = 0; i < s.size(); ++i) {
            currentShift += shift[i];
            s[i] = (s[i] - 'a' + (currentShift % 26) + 26) % 26 + 'a';
        }

        return s;
    }
};