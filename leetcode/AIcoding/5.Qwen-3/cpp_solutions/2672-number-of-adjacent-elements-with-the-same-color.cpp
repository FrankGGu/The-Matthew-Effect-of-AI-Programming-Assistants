#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int getNumberOfAdjacentElementsWithTheSameColor(vector<int>& colors, vector<vector<int>>& queries) {
        int n = colors.size();
        vector<int> left(n, -1);
        vector<int> right(n, -1);

        for (int i = 1; i < n; ++i) {
            if (colors[i] == colors[i - 1]) {
                left[i] = i - 1;
            } else {
                left[i] = left[i - 1];
            }
        }

        for (int i = n - 2; i >= 0; --i) {
            if (colors[i] == colors[i + 1]) {
                right[i] = i + 1;
            } else {
                right[i] = right[i + 1];
            }
        }

        vector<int> result;
        for (auto& q : queries) {
            int index = q[0];
            int color = q[1];
            if (colors[index] != color) {
                result.push_back(0);
                continue;
            }
            int count = 0;
            if (left[index] != -1 && colors[left[index]] == color) {
                count++;
            }
            if (right[index] != -1 && colors[right[index]] == color) {
                count++;
            }
            result.push_back(count);
        }
        return result.size();
    }
};