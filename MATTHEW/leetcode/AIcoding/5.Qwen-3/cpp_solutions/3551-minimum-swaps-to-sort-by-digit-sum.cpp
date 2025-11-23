#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int minimumSwapsToSortByDigitSum(vector<int>& nums) {
        vector<pair<int, int>> indexedNums;
        for (int i = 0; i < nums.size(); ++i) {
            indexedNums.push_back({nums[i], i});
        }

        auto digitSum = [](int n) {
            int sum = 0;
            while (n > 0) {
                sum += n % 10;
                n /= 10;
            }
            return sum;
        };

        sort(indexedNums.begin(), indexedNums.end(), [&](const pair<int, int>& a, const pair<int, int>& b) {
            int sumA = digitSum(a.first);
            int sumB = digitSum(b.first);
            if (sumA != sumB) {
                return sumA < sumB;
            }
            return a.second < b.second;
        });

        vector<bool> visited(nums.size(), false);
        int swaps = 0;

        for (int i = 0; i < nums.size(); ++i) {
            if (visited[i]) continue;
            int j = i;
            int cycleSize = 0;
            while (!visited[j]) {
                visited[j] = true;
                j = indexedNums[j].second;
                cycleSize++;
            }
            if (cycleSize > 1) {
                swaps += (cycleSize - 1);
            }
        }

        return swaps;
    }
};