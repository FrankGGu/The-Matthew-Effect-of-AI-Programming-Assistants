#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> closestEqualElement(vector<int>& arr, vector<vector<int>>& queries) {
        unordered_map<int, vector<int>> indices;
        for (int i = 0; i < arr.size(); ++i) {
            indices[arr[i]].push_back(i);
        }

        vector<int> result;
        for (const auto& query : queries) {
            int target = query[0];
            int pos = query[1];

            if (indices.find(target) == indices.end()) {
                result.push_back(-1);
                continue;
            }

            const vector<int>& vec = indices[target];
            auto it = lower_bound(vec.begin(), vec.end(), pos);

            int min_dist = INT_MAX;
            int best_idx = -1;

            if (it != vec.end()) {
                int dist = abs(*it - pos);
                if (dist < min_dist) {
                    min_dist = dist;
                    best_idx = *it;
                }
            }

            if (it != vec.begin()) {
                --it;
                int dist = abs(*it - pos);
                if (dist < min_dist) {
                    min_dist = dist;
                    best_idx = *it;
                } else if (dist == min_dist && *it < best_idx) {
                    best_idx = *it;
                }
            }

            result.push_back(best_idx);
        }

        return result;
    }
};