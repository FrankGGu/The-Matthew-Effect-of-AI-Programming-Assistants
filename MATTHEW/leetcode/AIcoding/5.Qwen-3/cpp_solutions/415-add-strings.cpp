#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string addStrings(string num1, string num2) {
        int i = num1.length() - 1;
        int j = num2.length() - 1;
        int carry = 0;
        string result;

        while (i >= 0 || j >= 0 || carry > 0) {
            int digit1 = (i >= 0) ? (num1[i] - '0') : 0;
            int digit2 = (j >= 0) ? (num2[j] - '0') : 0;
            int sum = digit1 + digit2 + carry;
            carry = sum / 10;
            result.push_back((sum % 10) + '0');
            i--;
            j--;
        }

        reverse(result.begin(), result.end());
        return result;
    }
};