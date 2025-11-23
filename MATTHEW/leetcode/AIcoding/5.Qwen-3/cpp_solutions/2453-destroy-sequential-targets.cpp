#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findRightmostTarget(vector<int>& targets, int start) {
        int n = targets.size();
        for (int i = n - 1; i >= 0; --i) {
            if (targets[i] == start) {
                return i;
            }
        }
        return -1;
    }

    int destroyTargets(vector<int>& targets, int space) {
        int n = targets.size();
        unordered_map<int, int> countMap;
        for (int i = 0; i < n; ++i) {
            int remainder = targets[i] % space;
            countMap[remainder]++;
        }

        int maxCount = 0;
        for (auto& [key, value] : countMap) {
            if (value > maxCount) {
                maxCount = value;
            }
        }

        int result = -1;
        for (int i = 0; i < n; ++i) {
            int remainder = targets[i] % space;
            if (countMap[remainder] == maxCount) {
                int rightmost = findRightmostTarget(targets, targets[i]);
                if (rightmost != -1) {
                    result = targets[rightmost];
                    break;
                }
            }
        }

        return result;
    }
};