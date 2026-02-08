#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int stoneGameIX(vector<int>& stones) {
        vector<int> count(3, 0);
        for (int s : stones) {
            count[s % 3]++;
        }

        if (count[1] == 0 || count[2] == 0) {
            return 0;
        }

        int minCount = min(count[1], count[2]);
        return minCount * 2;
    }
};