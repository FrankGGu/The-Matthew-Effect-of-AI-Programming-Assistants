#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int kthSmallest(vector<vector<int>>& matrix, int k) {
        priority_queue<int> maxHeap;
        for (const auto& row : matrix) {
            for (int num : row) {
                maxHeap.push(num);
                if (maxHeap.size() > k) {
                    maxHeap.pop();
                }
            }
        }
        return maxHeap.top();
    }
};