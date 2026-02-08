#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string largestPalindromic(string s) {
        unordered_map<char, int> count;
        for (char c : s) {
            count[c]++;
        }

        string evenPart;
        char middle = '\0';

        for (char c = '9'; c >= '0'; --c) {
            if (count[c] >= 2) {
                int times = count[c] / 2;
                evenPart.append(times, c);
                count[c] -= times * 2;
            }
        }

        for (char c = '9'; c >= '0'; --c) {
            if (count[c] > 0) {
                middle = c;
                break;
            }
        }

        string result = evenPart;
        if (middle != '\0') {
            result += middle;
        }
        reverse(evenPart.begin(), evenPart.end());
        result += evenPart;

        if (result.empty()) {
            return "0";
        }

        return result;
    }
};