#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string maxBinaryString(string binary) {
        int n = binary.size();
        int count = 0;
        int firstOne = -1;
        for (int i = 0; i < n; ++i) {
            if (binary[i] == '1') {
                if (firstOne == -1) {
                    firstOne = i;
                }
                ++count;
            }
        }
        if (count == n || count == 0) {
            return binary;
        }
        int zeros = 0;
        for (int i = firstOne; i < n; ++i) {
            if (binary[i] == '0') {
                ++zeros;
            } else {
                break;
            }
        }
        string result(n, '0');
        result[firstOne + zeros] = '1';
        return result;
    }
};