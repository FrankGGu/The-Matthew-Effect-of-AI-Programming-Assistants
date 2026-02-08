#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> readBinaryWatch(int num) {
        vector<string> result;
        for (int h = 0; h < 12; ++h) {
            for (int m = 0; m < 60; ++m) {
                if (bitCount(h) + bitCount(m) == num) {
                    string time;
                    time += to_string(h);
                    time += ":";
                    if (m < 10) {
                        time += "0";
                    }
                    time += to_string(m);
                    result.push_back(time);
                }
            }
        }
        return result;
    }

private:
    int bitCount(int n) {
        int count = 0;
        while (n) {
            count += n & 1;
            n >>= 1;
        }
        return count;
    }
};