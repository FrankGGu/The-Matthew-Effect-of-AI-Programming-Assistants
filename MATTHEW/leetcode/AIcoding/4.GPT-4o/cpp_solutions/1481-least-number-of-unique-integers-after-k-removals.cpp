#include <vector>
#include <unordered_map>
#include <queue>
#include <algorithm>

using namespace std;

int findLeastNumOfUniqueInts(vector<int>& arr, int k) {
    unordered_map<int, int> count;
    for (int num : arr) {
        count[num]++;
    }

    priority_queue<int, vector<int>, greater<int>> minHeap;
    for (auto& pair : count) {
        minHeap.push(pair.second);
    }

    while (k > 0 && !minHeap.empty()) {
        k -= minHeap.top();
        minHeap.pop();
    }

    return max(0, (int)minHeap.size() + (k < 0));
}