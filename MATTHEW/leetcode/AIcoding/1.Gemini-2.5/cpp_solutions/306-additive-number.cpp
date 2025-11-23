class Solution {
public:
    bool isAdditiveNumber(std::string num) {
        int n = num.length();
        for (int i = 0; i < n; ++i) {
            if (num[0] == '0' && i > 0) {
                break;
            }
            long long num1 = std::stoll(num.substr(0, i + 1));

            for (int j = i + 1; j < n; ++j) {
                if (num[i + 1] == '0' && j > i + 1) {
                    break;
                }
                long long num2 = std::stoll(num.substr(i + 1, j - i));

                if (check(num, num1, num2, j + 1)) {
                    return true;
                }
            }
        }
        return false;
    }

private:
    bool check(std::string num_str, long long prev1, long long prev2, int start_idx) {
        if (start_idx == num_str.length()) {
            return true;
        }

        long long sum = prev1 + prev2;
        std::string sum_s = std::to_string(sum);

        if (num_str.length() - start_idx < sum_s.length()) {
            return false;
        }
        if (num_str.substr(start_idx, sum_s.length()) == sum_s) {
            return check(num_str, prev2, sum, start_idx + sum_s.length());
        }
        return false;
    }
};