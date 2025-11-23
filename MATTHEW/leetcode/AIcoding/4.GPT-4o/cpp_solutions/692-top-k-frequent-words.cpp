#include <vector>
#include <string>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<string> topKFrequent(vector<string>& words, int k) {
        unordered_map<string, int> count;
        for (const auto& word : words) {
            count[word]++;
        }

        auto comp = [](const pair<string, int>& a, const pair<string, int>& b) {
            return a.second == b.second ? a.first > b.first : a.second < b.second;
        };

        priority_queue<pair<string, int>, vector<pair<string, int>>, decltype(comp)> minHeap(comp);

        for (const auto& entry : count) {
            minHeap.push(entry);
            if (minHeap.size() > k) {
                minHeap.pop();
            }
        }

        vector<string> result;
        while (!minHeap.empty()) {
            result.push_back(minHeap.top().first);
            minHeap.pop();
        }

        reverse(result.begin(), result.end());
        return result;
    }
};