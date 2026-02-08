class Solution {
public:
    int minimumLevels(vector<int>& possible) {
        int total = 0;
        for (int num : possible) {
            total += (num == 1) ? 1 : -1;
        }

        int prefix = 0;
        for (int i = 0; i < possible.size() - 1; ++i) {
            prefix += (possible[i] == 1) ? 1 : -1;
            if (2 * prefix > total) {
                return i + 1;
            }
        }

        return -1;
    }
};