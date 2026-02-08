class Solution {
public:
    int minimumOperations(string num) {
        int n = num.size();
        int res = n;
        bool found0 = false;
        bool found5 = false;

        for (int i = n - 1; i >= 0; --i) {
            if (found0 && num[i] == '0') {
                res = n - i - 2;
                break;
            }
            if (found0 && num[i] == '5') {
                res = n - i - 2;
                break;
            }
            if (found5 && num[i] == '2') {
                res = n - i - 2;
                break;
            }
            if (found5 && num[i] == '7') {
                res = n - i - 2;
                break;
            }
            if (num[i] == '0') {
                found0 = true;
            } else if (num[i] == '5') {
                found5 = true;
            }
        }

        if (found0) {
            res = min(res, n - 1);
        }

        return res;
    }
};