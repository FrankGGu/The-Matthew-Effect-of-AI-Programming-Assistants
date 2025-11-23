class Solution {
public:
    long long smallestNumber(long long num) {
        if (num == 0) return 0;
        bool isNegative = num < 0;
        num = abs(num);
        string strNum = to_string(num);
        sort(strNum.begin(), strNum.end());
        if (isNegative) {
            return -stoll(strNum);
        } else {
            if (strNum[0] == '0') {
                for (int i = 1; i < strNum.size(); ++i) {
                    if (strNum[i] != '0') {
                        swap(strNum[0], strNum[i]);
                        break;
                    }
                }
            }
            return stoll(strNum);
        }
    }
};