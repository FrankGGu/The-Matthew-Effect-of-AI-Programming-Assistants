#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>

using namespace std;

class Solution {
private:
    vector<int> prefixSums;
    int totalSum;

public:
    Solution(vector<int>& w) {
        totalSum = 0;
        for (int weight : w) {
            totalSum += weight;
            prefixSums.push_back(totalSum);
        }
        srand(time(0));
    }

    int pickIndex() {
        int target = rand() % totalSum;
        int left = 0, right = prefixSums.size() - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (prefixSums[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
};