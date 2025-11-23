#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    double findMedian(vector<int>& nums) {
        unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        vector<int> uniqueNums;
        for (auto const& [num, count] : counts) {
            uniqueNums.push_back(num);
        }

        sort(uniqueNums.begin(), uniqueNums.end());

        int n = uniqueNums.size();
        if (n % 2 == 0) {
            return (double)(uniqueNums[n / 2 - 1] + uniqueNums[n / 2]) / 2.0;
        } else {
            return (double)uniqueNums[n / 2];
        }
    }
};