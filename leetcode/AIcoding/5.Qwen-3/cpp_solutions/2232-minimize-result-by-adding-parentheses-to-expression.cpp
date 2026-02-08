#include <iostream>
#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    string minimizeResult(string expression) {
        int n = expression.size();
        int plusPos = -1;
        for (int i = 0; i < n; ++i) {
            if (expression[i] == '+') {
                plusPos = i;
                break;
            }
        }

        string left = expression.substr(0, plusPos);
        string right = expression.substr(plusPos + 1);

        int minVal = INT_MAX;
        string result;

        for (int i = 0; i < left.size(); ++i) {
            for (int j = 0; j < right.size(); ++j) {
                int a = stoi(left.substr(0, i));
                int b = stoi(left.substr(i));
                int c = stoi(right.substr(0, j));
                int d = stoi(right.substr(j));

                int val = (a + b) * (c + d);
                if (val < minVal) {
                    minVal = val;
                    result = "(" + left.substr(0, i) + "+" + left.substr(i) + ")" + right.substr(0, j) + "+" + right.substr(j);
                }
            }
        }

        return result;
    }
};