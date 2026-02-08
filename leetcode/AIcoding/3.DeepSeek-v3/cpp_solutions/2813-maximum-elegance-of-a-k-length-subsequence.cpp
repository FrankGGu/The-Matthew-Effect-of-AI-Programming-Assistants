#include <vector>
#include <algorithm>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    long long findMaximumElegance(vector<vector<int>>& items, int k) {
        sort(items.begin(), items.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] > b[0];
        });

        long long total_profit = 0;
        unordered_set<int> seen_categories;
        priority_queue<int, vector<int>, greater<int>> min_heap;

        for (int i = 0; i < k; ++i) {
            total_profit += items[i][0];
            int category = items[i][1];
            if (seen_categories.count(category)) {
                min_heap.push(items[i][0]);
            } else {
                seen_categories.insert(category);
            }
        }

        long long max_elegance = total_profit + (long long)seen_categories.size() * seen_categories.size();

        for (int i = k; i < items.size(); ++i) {
            int category = items[i][1];
            if (seen_categories.count(category) || min_heap.empty()) continue;
            int min_profit = min_heap.top();
            min_heap.pop();
            total_profit = total_profit - min_profit + items[i][0];
            seen_categories.insert(category);
            long long current_elegance = total_profit + (long long)seen_categories.size() * seen_categories.size();
            if (current_elegance > max_elegance) {
                max_elegance = current_elegance;
            }
        }

        return max_elegance;
    }
};