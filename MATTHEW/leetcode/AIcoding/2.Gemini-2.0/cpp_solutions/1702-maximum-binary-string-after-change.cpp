#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string maximumBinaryString(string binary) {
        int n = binary.size();
        int zeros = 0;
        int firstZero = -1;
        for (int i = 0; i < n; ++i) {
            if (binary[i] == '0') {
                zeros++;
                if (firstZero == -1) {
                    firstZero = i;
                }
            }
        }

        if (zeros <= 1) {
            return binary;
        }

        string result(n, '1');
        result[firstZero + zeros - 1] = '0';

        return result;
    }
};