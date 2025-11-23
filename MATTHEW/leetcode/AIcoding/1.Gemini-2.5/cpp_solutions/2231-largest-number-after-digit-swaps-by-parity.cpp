#include <string>
#include <vector>
#include <algorithm>
#include <functional>

class Solution {
public:
    int largestInteger(int num) {
        std::string s = std::to_string(num);
        std::vector<char> odds;
        std::vector<char> evens;

        for (char c : s) {
            if ((c - '0') % 2 == 0) {
                evens.push_back(c);
            } else {
                odds.push_back(c);
            }
        }

        std::sort(odds.begin(), odds.end(), std::greater<char>());
        std::sort(evens.begin(), evens.end(), std::greater<char>());

        std::string result_s = "";
        int odd_ptr = 0;
        int even_ptr = 0;

        for (char c : s) {
            if ((c - '0') % 2 == 0) {
                result_s += evens[even_ptr++];
            } else {
                result_s += odds[odd_ptr++];
            }
        }

        return std::stoi(result_s);
    }
};