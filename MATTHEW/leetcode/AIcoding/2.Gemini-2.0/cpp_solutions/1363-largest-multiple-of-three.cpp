#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestMultipleOfThree(vector<int>& digits) {
        vector<int> mod1;
        vector<int> mod2;
        int sum = 0;
        for (int digit : digits) {
            sum += digit;
            if (digit % 3 == 1) {
                mod1.push_back(digit);
            } else if (digit % 3 == 2) {
                mod2.push_back(digit);
            }
        }

        if (sum % 3 == 1) {
            if (!mod1.empty()) {
                digits.erase(remove(digits.begin(), digits.end(), *min_element(mod1.begin(), mod1.end())), digits.end());
            } else if (mod2.size() >= 2) {
                sort(mod2.begin(), mod2.end());
                digits.erase(remove(digits.begin(), digits.end(), mod2[0]), digits.end());
                digits.erase(remove(digits.begin(), digits.end(), mod2[1]), digits.end());
            } else {
                return "0";
            }
        } else if (sum % 3 == 2) {
            if (!mod2.empty()) {
                digits.erase(remove(digits.begin(), digits.end(), *min_element(mod2.begin(), mod2.end())), digits.end());
            } else if (mod1.size() >= 2) {
                sort(mod1.begin(), mod1.end());
                digits.erase(remove(digits.begin(), digits.end(), mod1[0]), digits.end());
                digits.erase(remove(digits.begin(), digits.end(), mod1[1]), digits.end());
            } else {
                return "0";
            }
        }

        sort(digits.begin(), digits.end(), greater<int>());

        if (digits.empty()) {
            return "0";
        }

        string result = "";
        for (int digit : digits) {
            result += to_string(digit);
        }

        if (result[0] == '0') {
            return "0";
        }

        return result;
    }
};