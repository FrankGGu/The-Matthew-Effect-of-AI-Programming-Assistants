#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int maximumOperations(string s) {
        int count = 0;
        int ones = 0;
        for (char c : s) {
            if (c == '1') {
                ones++;
            } else {
                if (ones > 0) {
                    count++;
                }
            }
        }
        return count;
    }
};