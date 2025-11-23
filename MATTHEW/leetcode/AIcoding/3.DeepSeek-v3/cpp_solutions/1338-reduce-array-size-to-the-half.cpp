#include <vector>
#include <unordered_map>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int minSetSize(vector<int>& arr) {
        unordered_map<int, int> freq;
        for (int num : arr) {
            freq[num]++;
        }

        priority_queue<int> maxHeap;
        for (auto& pair : freq) {
            maxHeap.push(pair.second);
        }

        int total = arr.size();
        int target = total / 2;
        int count = 0;
        int removed = 0;

        while (removed < target) {
            removed += maxHeap.top();
            maxHeap.pop();
            count++;
        }

        return count;
    }
};