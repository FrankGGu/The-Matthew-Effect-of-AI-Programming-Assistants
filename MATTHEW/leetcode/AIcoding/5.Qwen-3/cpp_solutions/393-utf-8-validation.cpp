#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool validUtf8(vector<int>& data) {
        int n = data.size();
        int i = 0;
        while (i < n) {
            int bytes = 0;
            if ((data[i] & 0x80) == 0) {
                bytes = 1;
            } else if ((data[i] & 0xE0) == 0xC0) {
                bytes = 2;
            } else if ((data[i] & 0xF0) == 0xE0) {
                bytes = 3;
            } else if ((data[i] & 0xF8) == 0xF0) {
                bytes = 4;
            } else {
                return false;
            }
            if (i + bytes > n) return false;
            for (int j = 1; j < bytes; j++) {
                if ((data[i + j] & 0xC0) != 0x80) return false;
            }
            i += bytes;
        }
        return true;
    }
};