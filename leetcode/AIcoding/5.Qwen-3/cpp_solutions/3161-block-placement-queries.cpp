#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> blockPlacementQueries(int n, vector<vector<int>>& queries) {
        vector<int> result;
        vector<int> positions;

        for (const auto& q : queries) {
            int k = q[0];
            int x = q[1];

            if (positions.empty()) {
                positions.push_back(x);
                result.push_back(0);
                continue;
            }

            int left = 0;
            int right = positions.size() - 1;
            int pos = -1;

            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (positions[mid] < x) {
                    pos = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }

            int insertPos = pos + 1;
            if (insertPos == 0) {
                result.push_back(0);
            } else if (insertPos == positions.size()) {
                result.push_back(0);
            } else {
                int leftNeighbor = positions[insertPos - 1];
                int rightNeighbor = positions[insertPos];
                int dist = min(x - leftNeighbor, rightNeighbor - x);
                result.push_back(dist);
            }

            positions.insert(positions.begin() + insertPos, x);
        }

        return result;
    }
};