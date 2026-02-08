#include <string>
#include <vector>

class Solution {
public:
    std::string removeDuplicates(std::string s) {
        std::string result_stack;
        for (char c : s) {
            if (!result_stack.empty() && result_stack.back() == c) {
                result_stack.pop_back();
            } else {
                result_stack.push_back(c);
            }
        }
        return result_stack;
    }
};