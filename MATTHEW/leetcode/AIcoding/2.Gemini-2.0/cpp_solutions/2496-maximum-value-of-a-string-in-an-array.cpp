#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumValue(vector<string>& strs) {
        int maxVal = 0;
        for (const string& s : strs) {
            bool isNumeric = true;
            for (char c : s) {
                if (!isdigit(c)) {
                    isNumeric = false;
                    break;
                }
            }

            if (isNumeric) {
                maxVal = max(maxVal, stoi(s));
            } else {
                maxVal = max(maxVal, (int)s.length());
            }
        }
        return maxVal;
    }
};