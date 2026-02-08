#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    long long findScore(vector<int>& nums) {
        int n = nums.size();
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        unordered_set<int> marked;

        for (int i = 0; i < n; ++i) {
            pq.push({nums[i], i});
        }

        long long score = 0;
        while (!pq.empty()) {
            auto current = pq.top();
            pq.pop();
            int val = current.first;
            int idx = current.second;

            if (marked.find(idx) == marked.end()) {
                score += val;
                marked.insert(idx);
                if (idx > 0) marked.insert(idx - 1);
                if (idx < n - 1) marked.insert(idx + 1);
            }
        }

        return score;
    }
};