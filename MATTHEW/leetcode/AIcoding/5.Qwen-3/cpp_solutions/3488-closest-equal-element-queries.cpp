#include <iostream>
#include <vector>
#include <climits>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> closestEqual(const vector<int>& nums, const vector<int>& queries) {
        int n = nums.size();
        vector<int> result(queries.size());

        for (int i = 0; i < queries.size(); ++i) {
            int q = queries[i];
            int minDist = INT_MAX;
            int closestVal = INT_MAX;

            for (int j = 0; j < n; ++j) {
                if (nums[j] == nums[q]) {
                    int dist = abs(j - q);
                    if (dist < minDist) {
                        minDist = dist;
                        closestVal = nums[j];
                    }
                }
            }

            if (minDist != INT_MAX) {
                result[i] = closestVal;
            } else {
                result[i] = -1;
            }
        }

        return result;
    }
};