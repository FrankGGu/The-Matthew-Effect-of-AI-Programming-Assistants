#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minDominoRotations(vector<int>& tops, vector<int>& bottoms) {
        int n = tops.size();
        int countTop[7] = {0}, countBot[7] = {0};
        int same[7] = {0};

        for (int i = 0; i < n; ++i) {
            countTop[tops[i]]++;
            countBot[bottoms[i]]++;
            if (tops[i] == bottoms[i]) {
                same[tops[i]]++;
            }
        }

        for (int i = 1; i <= 6; ++i) {
            if (countTop[i] + countBot[i] - same[i] == n) {
                return min(countTop[i], countBot[i]);
            }
        }

        return -1;
    }
};