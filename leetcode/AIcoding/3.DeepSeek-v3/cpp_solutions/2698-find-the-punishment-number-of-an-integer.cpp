class Solution {
public:
    bool checkPartition(string s, int idx, int sum, int target) {
        if (idx == s.size()) {
            return sum == target;
        }
        int num = 0;
        for (int i = idx; i < s.size(); ++i) {
            num = num * 10 + (s[i] - '0');
            if (checkPartition(s, i + 1, sum + num, target)) {
                return true;
            }
        }
        return false;
    }

    int punishmentNumber(int n) {
        int res = 0;
        for (int i = 1; i <= n; ++i) {
            int square = i * i;
            string s = to_string(square);
            if (checkPartition(s, 0, 0, i)) {
                res += square;
            }
        }
        return res;
    }
};