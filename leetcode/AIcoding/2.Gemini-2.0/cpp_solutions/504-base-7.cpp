#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string convertToBase7(int num) {
        if (num == 0) return "0";

        bool negative = num < 0;
        num = abs(num);

        string result = "";
        while (num > 0) {
            result += to_string(num % 7);
            num /= 7;
        }

        if (negative) {
            result += "-";
        }

        reverse(result.begin(), result.end());
        return result;
    }
};