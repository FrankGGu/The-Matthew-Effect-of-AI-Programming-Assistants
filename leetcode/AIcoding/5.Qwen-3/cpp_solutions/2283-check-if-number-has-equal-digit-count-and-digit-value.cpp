#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool digitCount(string num) {
        unordered_map<char, int> count;
        for (char c : num) {
            count[c]++;
        }
        for (int i = 0; i < num.length(); ++i) {
            char key = '0' + i;
            if (count[key] != num[i] - '0') {
                return false;
            }
        }
        return true;
    }
};