#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string maximumNumber(string number, vector<int>& mapping) {
        for (int i = 0; i < number.length(); ++i) {
            int digit = number[i] - '0';
            if (mapping[digit] != digit) {
                number[i] = '0' + mapping[digit];
            }
        }
        return number;
    }
};