#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSatisfaction(vector<int>& satisfaction) {
        sort(satisfaction.begin(), satisfaction.end());
        int n = satisfaction.size();
        int total = 0;
        int res = 0;
        for (int i = n - 1; i >= 0; --i) {
            total += satisfaction[i];
            if (total > 0) {
                res += total;
            } else {
                break;
            }
        }
        return res;
    }
};