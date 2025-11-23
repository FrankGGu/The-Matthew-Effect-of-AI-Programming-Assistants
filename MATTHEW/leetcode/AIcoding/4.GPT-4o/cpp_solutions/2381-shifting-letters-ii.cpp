class Solution {
public:
    string shiftingLetters(string s, vector<vector<int>>& shifts) {
        int n = s.size();
        vector<int> shift(n + 1, 0);

        for (auto& shift_info : shifts) {
            int start = shift_info[0], end = shift_info[1], direction = shift_info[2];
            int change = direction == 0 ? -1 : 1;
            shift[start] += change;
            if (end + 1 < n) {
                shift[end + 1] -= change;
            }
        }

        int current_shift = 0;
        for (int i = 0; i < n; ++i) {
            current_shift += shift[i];
            s[i] = (s[i] - 'a' + (current_shift % 26) + 26) % 26 + 'a';
        }

        return s;
    }
};