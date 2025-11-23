#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    bool checkIfBinaryStringHasAtMostOneSegmentOfOnes(string s) {
        bool foundOne = false;
        for (char c : s) {
            if (c == '1') {
                if (foundOne) {
                    return false;
                }
                foundOne = true;
            }
        }
        return true;
    }
};