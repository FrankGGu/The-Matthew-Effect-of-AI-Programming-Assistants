#include <vector>
#include <unordered_map>
#include <queue>
using namespace std;

class Solution {
public:
    int leastInterval(vector<char>& tasks, int n) {
        unordered_map<char, int> taskCount;
        for (char task : tasks) {
            taskCount[task]++;
        }

        priority_queue<int> maxHeap;
        for (auto& entry : taskCount) {
            maxHeap.push(entry.second);
        }

        int time = 0;
        while (!maxHeap.empty()) {
            vector<int> waitList;
            int cycles = min(n + 1, (int)maxHeap.size());
            for (int i = 0; i < cycles; i++) {
                if (!maxHeap.empty()) {
                    waitList.push_back(maxHeap.top());
                    maxHeap.pop();
                }
            }
            for (int count : waitList) {
                if (--count > 0) {
                    maxHeap.push(count);
                }
            }
            time += maxHeap.empty() ? waitList.size() : n + 1;
        }

        return time;
    }
};