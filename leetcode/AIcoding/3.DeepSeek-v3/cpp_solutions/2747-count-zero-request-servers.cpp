#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> countServers(int n, vector<vector<int>>& logs, int x, vector<int>& queries) {
        sort(logs.begin(), logs.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        unordered_map<int, int> active;
        vector<pair<int, int>> queryPairs;
        for (int i = 0; i < queries.size(); ++i) {
            queryPairs.emplace_back(queries[i], i);
        }
        sort(queryPairs.begin(), queryPairs.end());

        vector<int> res(queries.size());
        int left = 0, right = 0;
        for (auto& [query, idx] : queryPairs) {
            int start = query - x;
            int end = query;

            while (right < logs.size() && logs[right][1] <= end) {
                active[logs[right][0]]++;
                right++;
            }

            while (left < logs.size() && logs[left][1] < start) {
                active[logs[left][0]]--;
                if (active[logs[left][0]] == 0) {
                    active.erase(logs[left][0]);
                }
                left++;
            }

            res[idx] = n - active.size();
        }

        return res;
    }
};