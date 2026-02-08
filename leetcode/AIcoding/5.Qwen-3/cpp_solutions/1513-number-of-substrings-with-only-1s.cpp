#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numSubstringsWithOnly1s(string s) {
        int count = 0;
        int result = 0;
        for (char c : s) {
            if (c == '1') {
                count++;
                result += count;
            } else {
                count = 0;
            }
        }
        return result;
    }
};