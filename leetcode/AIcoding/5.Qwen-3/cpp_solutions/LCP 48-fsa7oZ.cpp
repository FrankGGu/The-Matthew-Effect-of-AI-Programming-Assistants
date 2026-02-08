#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int maxDistanceFromTheOrigin(string s) {
        int left = 0, right = 0, blank = 0;
        for (char c : s) {
            if (c == 'L') left++;
            else if (c == 'R') right++;
            else blank++;
        }
        return max(abs(left - right) + blank, abs(left - right) + blank);
    }
};