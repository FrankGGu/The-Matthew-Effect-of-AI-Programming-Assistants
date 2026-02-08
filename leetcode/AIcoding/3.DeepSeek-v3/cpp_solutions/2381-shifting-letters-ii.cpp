class Solution {
public:
    string shiftingLetters(string s, vector<vector<int>>& shifts) {
        int n = s.size();
        vector<int> diff(n + 1, 0);

        for (const auto& shift : shifts) {
            int start = shift[0];
            int end = shift[1];
            int dir = shift[2];
            int delta = (dir == 1) ? 1 : -1;
            diff[start] += delta;
            diff[end + 1] -= delta;
        }

        int currentShift = 0;
        for (int i = 0; i < n; ++i) {
            currentShift += diff[i];
            int original = s[i] - 'a';
            original = (original + currentShift) % 26;
            if (original < 0) original += 26;
            s[i] = 'a' + original;
        }

        return s;
    }
};