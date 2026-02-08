#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    bool isSumEqual(string const& s1, string const& s2, string const& target) {
        auto convert = [](string const& s) {
            int num = 0;
            for (char c : s) {
                num = num * 10 + (c - 'a');
            }
            return num;
        };
        return convert(s1) + convert(s2) == convert(target);
    }
};