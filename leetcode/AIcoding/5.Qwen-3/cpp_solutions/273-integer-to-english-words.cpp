#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string numberToWords(int num) {
        if (num == 0) return "Zero";
        return helper(num);
    }

private:
    vector<string> lessThan20 = {"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};
    vector<string> tens = {"", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};
    vector<string> thousands = {"", "Thousand", "Million", "Billion"};

    string helper(int num) {
        if (num == 0) return "";
        if (num < 20) return lessThan20[num];
        if (num < 100) return tens[num / 10] + (num % 10 ? " " + lessThan20[num % 10] : "");
        if (num < 1000) return helper(num / 100) + " Hundred" + (num % 100 ? " " + helper(num % 100) : "");
        for (int i = 3; i >= 0; --i) {
            int val = pow(1000, i);
            if (num >= val) {
                return helper(num / val) + " " + thousands[i] + (num % val ? " " + helper(num % val) : "");
            }
        }
        return "";
    }
};