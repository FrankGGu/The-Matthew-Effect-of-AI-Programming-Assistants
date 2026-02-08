#include <string>
#include <vector>

class Solution {
public:
    int minLength(std::string s) {
        std::string resultStack;
        for (char c : s) {
            if (!resultStack.empty()) {
                if ((c == 'B' && resultStack.back() == 'A') || 
                    (c == 'D' && resultStack.back() == 'C')) {
                    resultStack.pop_back();
                } else {
                    resultStack.push_back(c);
                }
            } else {
                resultStack.push_back(c);
            }
        }
        return resultStack.length();
    }
};