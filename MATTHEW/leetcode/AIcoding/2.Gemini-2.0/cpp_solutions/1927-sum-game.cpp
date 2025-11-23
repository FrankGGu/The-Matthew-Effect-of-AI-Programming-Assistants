class Solution {
public:
    bool sumGame(string num) {
        int n = num.size();
        int q_count = 0;
        int sum_diff = 0;
        for (int i = 0; i < n / 2; ++i) {
            if (num[i] == '?') {
                q_count++;
            } else {
                sum_diff += (num[i] - '0');
            }
        }
        for (int i = n / 2; i < n; ++i) {
            if (num[i] == '?') {
                q_count--;
            } else {
                sum_diff -= (num[i] - '0');
            }
        }
        if (q_count == 0) {
            return sum_diff != 0;
        }
        if (q_count % 2 != 0) {
            return true;
        }
        return sum_diff != (q_count / 2) * 9;
    }
};