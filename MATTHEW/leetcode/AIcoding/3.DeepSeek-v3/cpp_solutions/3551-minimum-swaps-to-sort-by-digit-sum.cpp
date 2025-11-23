#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int digitSum(int num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }

    int minimumSwaps(vector<int>& nums) {
        vector<pair<int, int>> indexedNums;
        for (int i = 0; i < nums.size(); ++i) {
            indexedNums.emplace_back(digitSum(nums[i]), i);
        }

        sort(indexedNums.begin(), indexedNums.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            if (a.first == b.first) {
                return a.second < b.second;
            }
            return a.first < b.first;
        });

        int swaps = 0;
        vector<bool> visited(nums.size(), false);

        for (int i = 0; i < nums.size(); ++i) {
            if (visited[i] || indexedNums[i].second == i) {
                continue;
            }

            int cycleSize = 0;
            int j = i;
            while (!visited[j]) {
                visited[j] = true;
                j = indexedNums[j].second;
                cycleSize++;
            }

            if (cycleSize > 0) {
                swaps += (cycleSize - 1);
            }
        }

        return swaps;
    }
};