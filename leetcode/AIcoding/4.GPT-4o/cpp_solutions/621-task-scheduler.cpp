#include <unordered_map>
#include <queue>
#include <vector>

using namespace std;

class Solution {
public:
    int leastInterval(vector<char>& tasks, int n) {
        unordered_map<char, int> count;
        for (char task : tasks) {
            count[task]++;
        }

        priority_queue<int> pq;
        for (auto& pair : count) {
            pq.push(pair.second);
        }

        int time = 0;

        while (!pq.empty()) {
            vector<int> temp;
            int k = min(n + 1, (int)pq.size());
            for (int i = 0; i < k; ++i) {
                temp.push_back(pq.top());
                pq.pop();
            }
            for (int remaining : temp) {
                if (--remaining > 0) {
                    pq.push(remaining);
                }
            }
            time += pq.empty() ? temp.size() : n + 1;
        }

        return time;
    }
};