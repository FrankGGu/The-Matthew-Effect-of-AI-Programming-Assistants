class Solution {
public:
    bool isAdditiveNumber(string num) {
        int n = num.size();
        for (int i = 1; i <= n / 2; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                if (isValid(num, 0, i, j)) return true;
            }
        }
        return false;
    }

    bool isValid(const string& num, int start, int len1, int len2) {
        if (start + len1 + len2 >= num.size()) return false;
        string first = num.substr(start, len1);
        string second = num.substr(start + len1, len2);
        if ((first.size() > 1 && first[0] == '0') || (second.size() > 1 && second[0] == '0')) return false;

        string sum;
        while (start + len1 + len2 < num.size()) {
            string next = addStrings(first, second);
            sum += next;
            start += len1 + len2;
            if (num.substr(start, next.size()) != next) return false;
            first = second;
            second = next;
            len1 = second.size();
            len2 = next.size();
        }
        return start == num.size();
    }

    string addStrings(const string& a, const string& b) {
        string result;
        int carry = 0;
        int i = a.size() - 1, j = b.size() - 1;
        while (i >= 0 || j >= 0 || carry) {
            int sum = carry;
            if (i >= 0) sum += a[i--] - '0';
            if (j >= 0) sum += b[j--] - '0';
            result.push_back(sum % 10 + '0');
            carry = sum / 10;
        }
        reverse(result.begin(), result.end());
        return result;
    }
};