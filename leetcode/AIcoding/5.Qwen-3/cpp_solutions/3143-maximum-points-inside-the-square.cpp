#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxPointsInsideSquare(vector<int>& points, vector<int>& queries) {
        vector<vector<int>> dists;
        for (int i = 0; i < points.size(); i++) {
            vector<int> row;
            for (int j = 0; j < points.size(); j++) {
                if (i == j) continue;
                int dx = abs(points[i] - points[j]);
                int dy = abs(points[i + 1] - points[j + 1]);
                row.push_back(max(dx, dy));
            }
            dists.push_back(row);
        }

        vector<int> result(queries.size(), 0);
        for (int q = 0; q < queries.size(); q++) {
            int r = queries[q];
            for (int i = 0; i < points.size(); i++) {
                int count = 0;
                for (int j = 0; j < points.size(); j++) {
                    if (i == j) continue;
                    int dx = abs(points[i] - points[j]);
                    int dy = abs(points[i + 1] - points[j + 1]);
                    if (max(dx, dy) <= r) {
                        count++;
                    }
                }
                result[q] = count;
            }
        }

        return result[0];
    }
};