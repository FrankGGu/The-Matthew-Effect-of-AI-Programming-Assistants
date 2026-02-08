#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestMultipleOfThree(vector<int>& digits) {
        sort(digits.begin(), digits.end(), greater<int>());
        int sum = 0;
        for (int d : digits) {
            sum += d;
        }
        if (sum % 3 == 0) {
            if (digits[0] == 0) return "0";
            string result;
            for (int d : digits) {
                result += to_string(d);
            }
            return result;
        }
        vector<int> mod1, mod2;
        for (int d : digits) {
            if (d % 3 == 1) mod1.push_back(d);
            else if (d % 3 == 2) mod2.push_back(d);
        }
        if (sum % 3 == 1) {
            if (!mod1.empty()) {
                vector<int>::iterator it = find(digits.begin(), digits.end(), mod1[0]);
                digits.erase(it);
            } else {
                if (mod2.size() >= 2) {
                    vector<int>::iterator it1 = find(digits.begin(), digits.end(), mod2[0]);
                    digits.erase(it1);
                    vector<int>::iterator it2 = find(digits.begin(), digits.end(), mod2[1]);
                    digits.erase(it2);
                }
            }
        } else {
            if (!mod2.empty()) {
                vector<int>::iterator it = find(digits.begin(), digits.end(), mod2[0]);
                digits.erase(it);
            } else {
                if (mod1.size() >= 2) {
                    vector<int>::iterator it1 = find(digits.begin(), digits.end(), mod1[0]);
                    digits.erase(it1);
                    vector<int>::iterator it2 = find(digits.begin(), digits.end(), mod1[1]);
                    digits.erase(it2);
                }
            }
        }
        if (digits.empty()) return "0";
        if (digits[0] == 0) return "0";
        string result;
        for (int d : digits) {
            result += to_string(d);
        }
        return result;
    }
};