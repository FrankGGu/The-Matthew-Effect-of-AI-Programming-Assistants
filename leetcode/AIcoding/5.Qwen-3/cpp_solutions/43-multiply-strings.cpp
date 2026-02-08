#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string multiply(string num1, string num2) {
        if (num1 == "0" || num2 == "0") return "0";

        int m = num1.size(), n = num2.size();
        vector<int> result(m + n, 0);

        for (int i = m - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                int digit1 = num1[i] - '0';
                int digit2 = num2[j] - '0';
                int product = digit1 * digit2;
                int pos1 = i + j;
                int pos2 = i + j + 1;
                int sum = product + result[pos2];
                result[pos2] = sum % 10;
                result[pos1] += sum / 10;
            }
        }

        string res;
        for (int i = 0; i < result.size(); i++) {
            if (!(res.empty() && result[i] == 0)) {
                res.push_back(result[i] + '0');
            }
        }

        return res;
    }
};