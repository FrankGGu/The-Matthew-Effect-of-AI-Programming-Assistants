#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getScore(vector<int>& m, vector<int>& o) {
        int score = 0;
        for (int i = 0; i < o.size(); ++i) {
            if (o[i] < m.size()) {
                score += m[o[i]];
                m[o[i]] = 0;
            }
        }
        return score;
    }
};