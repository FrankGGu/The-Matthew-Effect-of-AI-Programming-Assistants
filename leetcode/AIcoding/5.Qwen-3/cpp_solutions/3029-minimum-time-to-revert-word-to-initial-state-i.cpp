#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minimumTimeToRevertToInitialState(string s, int k) {
        int n = s.length();
        int time = 0;
        int i = 0;
        while (i < n) {
            i += k;
            time++;
        }
        return time;
    }
};