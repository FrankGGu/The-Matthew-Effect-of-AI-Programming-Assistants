class Solution {
public:
    int punishmentNumber(int n) {
        int punishment = 0;
        for (int i = 1; i <= n; ++i) {
            int square = i * i;
            if (isPunishmentNumber(square)) {
                punishment += square;
            }
        }
        return punishment;
    }

private:
    bool isPunishmentNumber(int num) {
        string str = to_string(num);
        int len = str.length();
        for (int i = 1; i < (1 << (len - 1)); ++i) {
            int sum = 0, last = 0;
            for (int j = 0; j < len; ++j) {
                last = last * 10 + (str[j] - '0');
                if (i & (1 << j)) {
                    sum += last;
                    last = 0;
                }
            }
            sum += last;
            if (sum == num) return true;
        }
        return false;
    }
};