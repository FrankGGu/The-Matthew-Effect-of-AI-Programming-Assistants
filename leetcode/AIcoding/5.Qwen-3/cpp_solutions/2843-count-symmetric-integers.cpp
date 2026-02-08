#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countSymmetricIntegers(const string& s) {
        unordered_map<char, int> count;
        for (char c : s) {
            count[c]++;
        }
        int result = 0;
        for (auto& [c, cnt] : count) {
            if (cnt % 2 == 0) {
                result += cnt / 2;
            }
        }
        return result;
    }
};