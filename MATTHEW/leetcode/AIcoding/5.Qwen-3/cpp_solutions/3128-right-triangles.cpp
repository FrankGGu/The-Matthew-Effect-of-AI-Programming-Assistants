#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfRightTriangles(vector<vector<int>>& coordinates, int numPoints, int numLines) {
        vector<pair<int, int>> points;
        for (const auto& coord : coordinates) {
            points.emplace_back(coord[0], coord[1]);
        }

        sort(points.begin(), points.end());

        int count = 0;
        for (int i = 0; i < numPoints; ++i) {
            vector<int> x_coords;
            vector<int> y_coords;
            for (int j = 0; j < numPoints; ++j) {
                if (i != j) {
                    if (points[i].first == points[j].first) {
                        x_coords.push_back(points[j].second);
                    }
                    if (points[i].second == points[j].second) {
                        y_coords.push_back(points[j].first);
                    }
                }
            }

            sort(x_coords.begin(), x_coords.end());
            sort(y_coords.begin(), y_coords.end());

            int x_unique = 1;
            for (int j = 1; j < x_coords.size(); ++j) {
                if (x_coords[j] != x_coords[j - 1]) {
                    ++x_unique;
                }
            }

            int y_unique = 1;
            for (int j = 1; j < y_coords.size(); ++j) {
                if (y_coords[j] != y_coords[j - 1]) {
                    ++y_unique;
                }
            }

            count += (x_unique - 1) * (y_unique - 1);
        }

        return count;
    }
};