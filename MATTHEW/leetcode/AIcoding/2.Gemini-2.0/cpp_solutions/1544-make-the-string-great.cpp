#include <string>

using namespace std;

class Solution {
public:
    string makeGood(string s) {
        string result = "";
        for (char c : s) {
            if (!result.empty() && ((islower(c) && isupper(result.back()) && tolower(c) == tolower(result.back())) ||
                                     (isupper(c) && islower(result.back()) && tolower(c) == tolower(result.back())))) {
                result.pop_back();
            } else {
                result.push_back(c);
            }
        }
        return result;
    }
};