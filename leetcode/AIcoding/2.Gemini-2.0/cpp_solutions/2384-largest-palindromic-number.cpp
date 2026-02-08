#include <string>
#include <algorithm>
#include <vector>

using namespace std;

class Solution {
public:
    string largestPalindromic(string num) {
        vector<int> counts(10, 0);
        for (char c : num) {
            counts[c - '0']++;
        }

        string left = "";
        for (int i = 9; i >= 0; i--) {
            int pairs = counts[i] / 2;
            for (int j = 0; j < pairs; j++) {
                left += to_string(i);
            }
        }

        if (left.empty()) {
            int maxDigit = -1;
            for (int i = 9; i >= 0; i--) {
                if (counts[i] > 0) {
                    maxDigit = i;
                    break;
                }
            }
            if (maxDigit == 0) return "0";
            return to_string(maxDigit);
        }

        string middle = "";
        for (int i = 9; i >= 0; i--) {
            if (counts[i] % 2 == 1) {
                middle = to_string(i);
                break;
            }
        }

        if (left[0] == '0') {
            if (middle.empty()) {
                return "0";
            } else {
                return middle;
            }
        }

        string right = left;
        reverse(right.begin(), right.end());

        return left + middle + right;
    }
};