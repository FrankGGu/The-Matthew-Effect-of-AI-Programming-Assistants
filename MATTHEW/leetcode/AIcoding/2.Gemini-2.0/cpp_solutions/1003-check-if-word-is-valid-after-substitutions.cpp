#include <string>

using namespace std;

class Solution {
public:
    bool isValid(string s) {
        string stack;
        for (char c : s) {
            stack += c;
            if (stack.length() >= 3 && stack.substr(stack.length() - 3) == "abc") {
                stack.erase(stack.length() - 3);
            }
        }
        return stack.empty();
    }
};