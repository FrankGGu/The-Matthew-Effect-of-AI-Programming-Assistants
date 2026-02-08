#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumScore(int a, int b, int c) {
        vector<int> stones = {a, b, c};
        sort(stones.begin(), stones.end());
        if (stones[0] + stones[1] <= stones[2]) {
            return stones[0] + stones[1];
        } else {
            return (a + b + c) / 2;
        }
    }
};