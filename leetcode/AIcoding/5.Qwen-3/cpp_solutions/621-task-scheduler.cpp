#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int leastInterval(vector<char>& tasks, int n) {
        unordered_map<char, int> freq;
        for (char task : tasks) {
            freq[task]++;
        }

        priority_queue<pair<int, char>> maxHeap;
        for (auto& [task, count] : freq) {
            maxHeap.push({count, task});
        }

        int time = 0;
        while (!maxHeap.empty()) {
            int i = 0;
            vector<pair<int, char>> temp;
            while (i <= n && !maxHeap.empty()) {
                auto [count, task] = maxHeap.top();
                maxHeap.pop();
                if (count - 1 > 0) {
                    temp.push_back({count - 1, task});
                }
                i++;
                time++;
            }
            for (auto& [count, task] : temp) {
                maxHeap.push({count, task});
            }
        }
        return time;
    }
};