#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string multiply(string num1, string num2) {
        if (num1 == "0" || num2 == "0") return "0";

        int n1 = num1.size();
        int n2 = num2.size();
        vector<int> product(n1 + n2, 0);

        for (int i = n1 - 1; i >= 0; --i) {
            for (int j = n2 - 1; j >= 0; --j) {
                int digit1 = num1[i] - '0';
                int digit2 = num2[j] - '0';
                int p = digit1 * digit2;
                int p1 = i + j;
                int p2 = i + j + 1;
                int sum = p + product[p2];

                product[p2] = sum % 10;
                product[p1] += sum / 10;
            }
        }

        string result = "";
        for (int digit : product) {
            if (!(result.empty() && digit == 0)) {
                result += to_string(digit);
            }
        }

        return result.empty() ? "0" : result;
    }
};