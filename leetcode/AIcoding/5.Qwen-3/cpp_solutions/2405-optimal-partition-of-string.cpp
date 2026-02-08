#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int partitionString(string s) {
        unordered_set<char> seen;
        int count = 1;
        for (char c : s) {
            if (seen.find(c) != seen.end()) {
                seen.clear();
                count++;
            }
            seen.insert(c);
        }
        return count;
    }
};