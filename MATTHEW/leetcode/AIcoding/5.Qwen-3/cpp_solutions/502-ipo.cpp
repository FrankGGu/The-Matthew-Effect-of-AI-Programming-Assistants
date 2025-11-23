#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int findMaximizedCapital(int k, int w, vector<int>& profits, vector<int>& capital) {
        vector<pair<int, int>> projects(profits.size());
        for (int i = 0; i < profits.size(); ++i) {
            projects[i] = {capital[i], profits[i]};
        }

        sort(projects.begin(), projects.end());

        priority_queue<int> maxHeap;
        int i = 0;

        while (k--) {
            while (i < projects.size() && projects[i].first <= w) {
                maxHeap.push(projects[i].second);
                ++i;
            }

            if (!maxHeap.empty()) {
                w += maxHeap.top();
                maxHeap.pop();
            }
        }

        return w;
    }
};