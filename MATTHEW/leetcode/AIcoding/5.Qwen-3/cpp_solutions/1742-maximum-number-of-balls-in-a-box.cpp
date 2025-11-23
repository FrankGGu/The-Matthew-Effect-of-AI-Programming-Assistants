#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxBallsInBox(int n, vector<int>& quantities) {
        unordered_map<int, int> count;
        for (int q : quantities) {
            count[q]++;
        }

        int maxBalls = 0;
        for (auto& [key, value] : count) {
            maxBalls = max(maxBalls, key * value);
        }

        return maxBalls;
    }
};