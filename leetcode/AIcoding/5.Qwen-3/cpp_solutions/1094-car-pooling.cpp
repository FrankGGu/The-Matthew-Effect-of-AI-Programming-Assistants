#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool carPooling(vector<vector<int>>& trips) {
        vector<int> change(1001, 0);
        for (const auto& trip : trips) {
            int num = trip[0];
            int from = trip[1];
            int to = trip[2];
            change[from] += num;
            change[to] -= num;
        }
        int passengers = 0;
        for (int i = 0; i <= 1000; ++i) {
            passengers += change[i];
            if (passengers > 5) {
                return false;
            }
        }
        return true;
    }
};