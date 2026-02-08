class Solution {
public:
    bool isAdditiveNumber(string num) {
        int n = num.size();
        for (int i = 1; i <= n / 2; ++i) {
            for (int j = 1; j <= (n - i) / 2; ++j) {
                if (isAdditive(num, 0, i, j)) {
                    return true;
                }
            }
        }
        return false;
    }

private:
    bool isAdditive(string num, int start, int len1, int len2) {
        if (start + len1 + len2 == num.size()) {
            return true;
        }

        long long num1 = stoll(num.substr(start, len1));
        long long num2 = stoll(num.substr(start + len1, len2));
        string sumStr = to_string(num1 + num2);

        if (num.substr(start + len1 + len2).rfind(sumStr, 0) == 0) {
            if ((num.substr(start, len1).length() > 1 && num[start] == '0') || (num.substr(start + len1, len2).length() > 1 && num[start + len1] == '0') || (sumStr.length() > 1 && sumStr[0] == '0' && sumStr.length() != 1))
                return false;
            return isAdditive(num, start + len1, len2, sumStr.length());
        }

        return false;
    }
};