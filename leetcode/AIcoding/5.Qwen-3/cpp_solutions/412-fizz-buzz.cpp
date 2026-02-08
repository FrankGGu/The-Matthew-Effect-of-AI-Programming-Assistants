#include <iostream>
#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::string> fizzBuzz(int n) {
        std::vector<std::string> result;
        for (int i = 1; i <= n; ++i) {
            std::string s;
            if (i % 3 == 0) s += "Fizz";
            if (i % 5 == 0) s += "Buzz";
            if (s.empty()) s = std::to_string(i);
            result.push_back(s);
        }
        return result;
    }
};