#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int sumIndicesWithKSetBitsInBinary(string s, int k) {
        int result = 0;
        for (int i = 0; i < s.size(); ++i) {
            int count = 0;
            int num = i;
            while (num > 0) {
                count += num & 1;
                num >>= 1;
            }
            if (count == k) {
                result += s[i] - '0';
            }
        }
        return result;
    }
};