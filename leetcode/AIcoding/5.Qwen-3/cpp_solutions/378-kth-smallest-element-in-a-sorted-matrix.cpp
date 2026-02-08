#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int kthSmallest(vector<vector<int>>& matrix, int k) {
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> minHeap;
        minHeap.push({matrix[0][0], {0, 0}});
        vector<vector<bool>> visited(matrix.size(), vector<bool>(matrix[0].size(), false));
        visited[0][0] = true;

        int count = 0;
        while (!minHeap.empty()) {
            auto top = minHeap.top();
            minHeap.pop();
            count++;
            if (count == k) {
                return top.first;
            }
            int row = top.second.first;
            int col = top.second.second;
            if (row + 1 < matrix.size() && !visited[row + 1][col]) {
                visited[row + 1][col] = true;
                minHeap.push({matrix[row + 1][col], {row + 1, col}});
            }
            if (col + 1 < matrix[0].size() && !visited[row][col + 1]) {
                visited[row][col + 1] = true;
                minHeap.push({matrix[row][col + 1], {row, col + 1}});
            }
        }
        return -1;
    }
};