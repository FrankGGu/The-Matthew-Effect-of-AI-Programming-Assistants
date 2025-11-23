#include <iostream>
#include <vector>
#include <map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> mostFrequentIDs(const vector<int>& ids) {
        map<long long, int> freq;
        priority_queue<pair<int, long long>> maxHeap;
        vector<int> result;

        for (int id : ids) {
            freq[id]++;
            maxHeap.push({freq[id], id});
        }

        while (!maxHeap.empty()) {
            auto [count, id] = maxHeap.top();
            result.push_back(id);
            maxHeap.pop();
        }

        return result;
    }
};