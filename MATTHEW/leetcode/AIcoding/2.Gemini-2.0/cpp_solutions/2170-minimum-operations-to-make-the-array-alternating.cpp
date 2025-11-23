#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) return 0;

        unordered_map<int, int> evenCounts;
        unordered_map<int, int> oddCounts;

        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) {
                evenCounts[nums[i]]++;
            } else {
                oddCounts[nums[i]]++;
            }
        }

        vector<pair<int, int>> evenSorted(evenCounts.begin(), evenCounts.end());
        vector<pair<int, int>> oddSorted(oddCounts.begin(), oddCounts.end());

        sort(evenSorted.begin(), evenSorted.end(), [](const auto& a, const auto& b) {
            return a.second > b.second;
        });

        sort(oddSorted.begin(), oddSorted.end(), [](const auto& a, const auto& b) {
            return a.second > b.second;
        });

        if (evenSorted[0].first != oddSorted[0].first) {
            return n - evenSorted[0].second - oddSorted[0].second;
        } else {
            int evenSecondMax = (evenSorted.size() > 1) ? evenSorted[1].second : 0;
            int oddSecondMax = (oddSorted.size() > 1) ? oddSorted[1].second : 0;
            return min(n - evenSorted[0].second - oddSecondMax, n - evenSecondMax - oddSorted[0].second);
        }
    }
};