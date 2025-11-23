#include <vector>
#include <queue>
#include <algorithm>
#include <utility> // For std::pair

class Solution {
public:
    int findMaximizedCapital(int k, int w, std::vector<int>& profits, std::vector<int>& capital) {
        int n = profits.size();
        std::vector<std::pair<int, int>> projects(n);
        for (int i = 0; i < n; ++i) {
            projects[i] = {capital[i], profits[i]};
        }

        std::sort(projects.begin(), projects.end());

        std::priority_queue<int> maxProfitHeap;

        int currentCapital = w;
        int projectIndex = 0;

        for (int i = 0; i < k; ++i) {
            while (projectIndex < n && projects[projectIndex].first <= currentCapital) {
                maxProfitHeap.push(projects[projectIndex].second);
                projectIndex++;
            }

            if (maxProfitHeap.empty()) {
                break;
            }

            currentCapital += maxProfitHeap.top();
            maxProfitHeap.pop();
        }

        return currentCapital;
    }
};