#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int addRungs(vector<int>& rungs, int dist) {
        int prev = 0;
        int count = 0;
        for (int& r : rungs) {
            if (r - prev > dist) {
                count += (r - prev - 1) / dist;
            }
            prev = r;
        }
        return count;
    }
};