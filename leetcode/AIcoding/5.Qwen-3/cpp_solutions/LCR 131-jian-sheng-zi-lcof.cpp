#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int chop竹子(vector<int>& rods) {
        priority_queue<int> maxHeap;
        for (int rod : rods) {
            maxHeap.push(rod);
        }

        int result = 0;
        while (maxHeap.size() > 1) {
            int a = maxHeap.top();
            maxHeap.pop();
            int b = maxHeap.top();
            maxHeap.pop();
            int c = a - b;
            result += b;
            if (c > 0) {
                maxHeap.push(c);
            }
        }
        return result;
    }
};