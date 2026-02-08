#include <iostream>
#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maximumSquareArea(int n, vector<int>& leftFences, vector<int>& rightFences) {
        sort(leftFences.begin(), leftFences.end());
        sort(rightFences.begin(), rightFences.end());

        unordered_map<int, int> leftMap;
        for (int i = 0; i < leftFences.size(); ++i) {
            leftMap[leftFences[i]] = i;
        }

        unordered_map<int, int> rightMap;
        for (int i = 0; i < rightFences.size(); ++i) {
            rightMap[rightFences[i]] = i;
        }

        int maxSide = 0;
        int m = leftFences.size();
        int k = rightFences.size();

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < k; ++j) {
                if (leftFences[i] == rightFences[j]) {
                    continue;
                }
                int l = leftFences[i];
                int r = rightFences[j];
                if (l < r) {
                    int side = r - l;
                    if (side > maxSide) {
                        maxSide = side;
                    }
                }
            }
        }

        return maxSide * maxSide;
    }
};