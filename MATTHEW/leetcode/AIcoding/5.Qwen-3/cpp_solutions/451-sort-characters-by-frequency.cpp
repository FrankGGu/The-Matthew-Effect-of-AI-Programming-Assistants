#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    string frequencySort(string s) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        priority_queue<pair<int, char>> maxHeap;
        for (auto& p : freq) {
            maxHeap.push({p.second, p.first});
        }

        string result;
        while (!maxHeap.empty()) {
            auto top = maxHeap.top();
            maxHeap.pop();
            result.append(top.first, top.second);
        }

        return result;
    }
};