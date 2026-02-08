#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string multiply(std::string num1, std::string num2) {
        if (num1 == "0" || num2 == "0") {
            return "0";
        }

        int m = num1.length();
        int n = num2.length();
        std::vector<int> res(m + n, 0);

        for (int i = m - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                int mul = (num1[i] - '0') * (num2[j] - '0');
                int sum = mul + res[i + j + 1];

                res[i + j + 1] = sum % 10;
                res[i + j] += sum / 10;
            }
        }

        std::string result_str = "";
        int i = 0;
        while (i < res.size() && res[i] == 0) {
            i++;
        }

        while (i < res.size()) {
            result_str += std::to_string(res[i]);
            i++;
        }

        return result_str;
    }
};