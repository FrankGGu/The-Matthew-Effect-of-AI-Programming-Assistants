#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> findRelativeRanks(vector<int>& nums) {
        vector<int> sorted = nums;
        sort(sorted.begin(), sorted.end(), greater<int>());
        map<int, int> rankMap;
        for (int i = 0; i < sorted.size(); ++i) {
            rankMap[sorted[i]] = i + 1;
        }
        vector<string> result;
        for (int num : nums) {
            int rank = rankMap[num];
            if (rank == 1) {
                result.push_back("Gold Medal");
            } else if (rank == 2) {
                result.push_back("Silver Medal");
            } else if (rank == 3) {
                result.push_back("Bronze Medal");
            } else {
                result.push_back(to_string(rank));
            }
        }
        return result;
    }
};