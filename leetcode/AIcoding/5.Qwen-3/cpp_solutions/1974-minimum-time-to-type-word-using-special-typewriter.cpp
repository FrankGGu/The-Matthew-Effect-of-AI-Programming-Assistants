#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minTimeToType(string word) {
        int time = 0;
        int prev = 0;
        for (char c : word) {
            int curr = c - 'a';
            int diff = abs(curr - prev);
            time += min(diff, 26 - diff);
            prev = curr;
        }
        return time;
    }
};