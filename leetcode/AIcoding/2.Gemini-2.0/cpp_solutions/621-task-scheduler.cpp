#include <vector>
#include <queue>
#include <map>

using namespace std;

class Solution {
public:
    int leastInterval(vector<char>& tasks, int n) {
        map<char, int> task_counts;
        for (char task : tasks) {
            task_counts[task]++;
        }

        priority_queue<int> pq;
        for (auto const& [key, val] : task_counts) {
            pq.push(val);
        }

        int cycles = 0;
        while (!pq.empty()) {
            vector<int> temp;
            int count = 0;
            for (int i = 0; i <= n; ++i) {
                if (!pq.empty()) {
                    temp.push_back(pq.top());
                    pq.pop();
                    count++;
                } else {
                    break;
                }
            }

            for (int val : temp) {
                if (val > 1) {
                    pq.push(val - 1);
                }
            }

            if (pq.empty()) {
                cycles += count;
            } else {
                cycles += (n + 1);
            }
        }

        return cycles;
    }
};