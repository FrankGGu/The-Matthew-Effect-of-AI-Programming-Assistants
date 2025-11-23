#include <string>
#include <stack>
#include <cctype>

class Solution {
public:
    bool isValid(std::string code) {
        std::stack<std::string> st;
        for (int i = 0; i < code.length(); ) {
            if (i > 0 && st.empty()) {
                return false;
            }

            if (code.rfind("<