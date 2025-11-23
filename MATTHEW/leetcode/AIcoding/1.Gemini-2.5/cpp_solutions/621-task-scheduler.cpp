#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int leastInterval(vector<char>& tasks, int n) {
        vector<int> counts(26, 0);
        for (char task : tasks) {
            counts[task - 'A']++;
        }

        priority_queue<int> pq;
        for (int count : counts) {
            if (count > 0) {
                pq.push(count);
            }
        }

        int time = 0;
        while (!pq.empty()) {
            vector<int> temp;
            int k = n + 1;
            for (int i = 0; i < k; ++i) {
                if (!pq.empty()) {
                    temp.push_back(pq.top());
                    pq.pop();
                }
            }

            for (int count : temp) {
                if (--count > 0) {
                    pq.push(count);
                }
            }

            time += (pq.empty() ? temp.size() : k);
        }

        return time;
    }
};