#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    char repeatedCharacter(string s) {
        unordered_set<char> seen;
        for (char c : s) {
            if (seen.find(c) != seen.end()) {
                return c;
            }
            seen.insert(c);
        }
        return ' ';
    }
};