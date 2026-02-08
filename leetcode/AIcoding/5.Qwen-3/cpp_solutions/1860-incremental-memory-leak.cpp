#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> memLeak(int n) {
        int time = 1;
        while (n > 0) {
            if (n <= time) {
                return {time, n};
            }
            n -= time;
            time++;
        }
        return {time, n};
    }
};