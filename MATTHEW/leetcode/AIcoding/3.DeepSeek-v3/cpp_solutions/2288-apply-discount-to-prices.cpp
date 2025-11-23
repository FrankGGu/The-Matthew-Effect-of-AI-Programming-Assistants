class Solution {
public:
    string discountPrices(string sentence, int discount) {
        string res;
        int n = sentence.size();
        for (int i = 0; i < n; ) {
            if (sentence[i] == '$' && (i == 0 || sentence[i-1] == ' ')) {
                int j = i + 1;
                bool isPrice = true;
                string numStr;
                while (j < n && isdigit(sentence[j])) {
                    numStr += sentence[j];
                    j++;
                }
                if (j == i + 1) {
                    isPrice = false;
                }
                if (j < n && sentence[j] != ' ') {
                    isPrice = false;
                }
                if (isPrice) {
                    long long price = stoll(numStr);
                    double discounted = price * (100 - discount) / 100.0;
                    char buf[50];
                    sprintf(buf, "%.2lf", discounted);
                    res += '$' + string(buf);
                    i = j;
                } else {
                    res += sentence[i];
                    i++;
                }
            } else {
                res += sentence[i];
                i++;
            }
        }
        return res;
    }
};