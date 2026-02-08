#include <string>

using namespace std;

class Solution {
public:
    string makeFancyString(string s) {
        string result = "";
        int count = 0;
        char prev = ' ';

        for (char c : s) {
            if (c == prev) {
                count++;
            } else {
                count = 1;
            }

            if (count <= 2) {
                result += c;
            }

            prev = c;
        }

        return result;
    }
};