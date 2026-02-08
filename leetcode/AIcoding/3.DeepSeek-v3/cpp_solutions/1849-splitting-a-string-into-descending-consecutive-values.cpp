class Solution {
public:
    bool splitString(string s) {
        return backtrack(s, 0, -1, 0);
    }

private:
    bool backtrack(const string& s, int start, long prev, int count) {
        if (start == s.size()) {
            return count >= 2;
        }

        long num = 0;
        for (int i = start; i < s.size(); ++i) {
            num = num * 10 + (s[i] - '0');
            if (num > 1e10) break; // Prevent overflow
            if (prev == -1 || num == prev - 1) {
                if (backtrack(s, i + 1, num, count + 1)) {
                    return true;
                }
            }
            if (prev != -1 && num >= prev) break;
        }
        return false;
    }
};