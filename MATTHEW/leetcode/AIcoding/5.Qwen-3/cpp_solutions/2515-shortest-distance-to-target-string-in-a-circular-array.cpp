#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int closetTarget(vector<string>& targetWords, string target, int startIndices) {
        int n = targetWords.size();
        int minDistance = INT_MAX;
        for (int i = 0; i < n; ++i) {
            if (targetWords[i] == target) {
                int distance = min(abs(i - startIndices), n - abs(i - startIndices));
                minDistance = min(minDistance, distance);
            }
        }
        return minDistance;
    }
};