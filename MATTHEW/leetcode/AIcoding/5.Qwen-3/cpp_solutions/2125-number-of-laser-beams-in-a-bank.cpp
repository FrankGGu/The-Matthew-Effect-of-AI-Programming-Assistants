#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numberOfLaserBeams(vector<string>& bank) {
        int prev = 0;
        int count = 0;
        for (const string& row : bank) {
            int curr = 0;
            for (char c : row) {
                if (c == '1') {
                    curr++;
                }
            }
            if (curr > 0) {
                count += prev * curr;
                prev = curr;
            }
        }
        return count;
    }
};