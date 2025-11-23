#include <string>
#include <sstream>
#include <algorithm>

using namespace std;

class Solution {
public:
    string reverseWords(string s) {
        stringstream ss(s);
        string word;
        string result = "";
        while (ss >> word) {
            if (!result.empty()) {
                result = word + " " + result;
            } else {
                result = word;
            }
        }
        return result;
    }
};