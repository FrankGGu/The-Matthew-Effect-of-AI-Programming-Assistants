class Solution {
public:
    string reformatNumber(string number) {
        number.erase(remove(number.begin(), number.end(), ' '), number.end());
        number.erase(remove(number.begin(), number.end(), '-'), number.end());

        string result;
        int n = number.size();
        int i = 0;

        while (i < n) {
            if (n - i > 4) {
                result += number.substr(i, 3) + "-";
                i += 3;
            } else {
                if (n - i == 4) {
                    result += number.substr(i, 2) + "-" + number.substr(i + 2, 2);
                } else {
                    result += number.substr(i);
                }
                break;
            }
        }

        return result;
    }
};