class Solution {
public:
    bool isAdditiveNumber(string num) {
        int n = num.size();
        for (int i = 1; i <= n / 2; ++i) {
            for (int j = 1; j <= (n - i) / 2; ++j) {
                if (check(num.substr(0, i), num.substr(i, j), num.substr(i + j))) {
                    return true;
                }
            }
        }
        return false;
    }

    bool check(string num1, string num2, string remaining) {
        if ((num1.size() > 1 && num1[0] == '0') || (num2.size() > 1 && num2[0] == '0')) {
            return false;
        }
        string sum = add(num1, num2);
        if (sum == remaining) {
            return true;
        }
        if (remaining.size() < sum.size() || remaining.substr(0, sum.size()) != sum) {
            return false;
        }
        return check(num2, sum, remaining.substr(sum.size()));
    }

    string add(string num1, string num2) {
        string res;
        int i = num1.size() - 1, j = num2.size() - 1, carry = 0;
        while (i >= 0 || j >= 0 || carry) {
            int n1 = i >= 0 ? num1[i--] - '0' : 0;
            int n2 = j >= 0 ? num2[j--] - '0' : 0;
            int sum = n1 + n2 + carry;
            res.push_back(sum % 10 + '0');
            carry = sum / 10;
        }
        reverse(res.begin(), res.end());
        return res;
    }
};