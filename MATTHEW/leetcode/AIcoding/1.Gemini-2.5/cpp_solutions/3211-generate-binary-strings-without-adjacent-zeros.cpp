#include <vector>
#include <string>
#include <functional>

class Solution {
public:
    std::vector<std::string> generateBinaryStrings(int n) {
        std::vector<std::string> result;
        std::string current_string = "";

        std::function<void(int)> backtrack = 
            [&](int k) { // k is the current index to fill (0 to n-1)
            if (k == n) {
                result.push_back(current_string);
                return;
            }

            // Option 1: Add '1'
            current_string.push_back('1');
            backtrack(k + 1);
            current_string.pop_back();

            // Option 2: Add '0'
            // A '0' can be added only if it's the first character (k == 0)
            // OR the previous character (at index k-1) was '1'
            if (k == 0 || current_string[k - 1] == '1') {
                current_string.push_back('0');
                backtrack(k + 1);
                current_string.pop_back();
            }
        };

        backtrack(0);
        return result;
    }
};