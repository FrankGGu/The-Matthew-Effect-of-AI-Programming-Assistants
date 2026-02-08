#include <string>
#include <sstream>
#include <cctype>

class Solution {
public:
    bool areNumbersAscending(std::string s) {
        std::stringstream ss(s);
        std::string token;
        int prev_num = -1; 

        while (ss >> token) {
            bool is_number = true;
            for (char c : token) {
                if (!std::isdigit(c)) {
                    is_number = false;
                    break;
                }
            }

            if (is_number) {
                int current_num = std::stoi(token);
                if (current_num <= prev_num) {
                    return false;
                }
                prev_num = current_num;
            }
        }
        return true;
    }
};