class Solution {
public:
    bool canWin(string current) {
        int n = current.size();
        for (int i = 0; i < n - 1; ++i) {
            if (current[i] == current[i + 1] && current[i] == '1') {
                current[i] = current[i + 1] = '0';
                if (!canWin(current)) {
                    return true;
                }
                current[i] = current[i + 1] = '1';
            }
        }
        return false;
    }
};