#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int garbageCollection(vector<string>& garbage, vector<int>& travel) {
        int n = garbage.size();
        int time = 0;

        for (int i = 0; i < n; ++i) {
            time += garbage[i].size();
        }

        for (int i = 1; i < n; ++i) {
            time += travel[i - 1];
        }

        return time;
    }
};