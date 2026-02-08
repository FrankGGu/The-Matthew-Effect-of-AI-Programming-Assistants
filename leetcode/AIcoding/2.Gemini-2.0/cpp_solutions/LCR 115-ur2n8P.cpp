#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool sequenceReconstruction(vector<int>& org, vector<vector<int>>& seqs) {
        unordered_map<int, vector<int>> adj;
        unordered_map<int, int> inDegree;
        unordered_map<int, bool> seen;

        for (auto& seq : seqs) {
            for (int num : seq) {
                seen[num] = true;
            }
        }

        for (auto& seq : seqs) {
            for (int i = 0; i < seq.size() - 1; ++i) {
                int u = seq[i];
                int v = seq[i + 1];
                adj[u].push_back(v);
                inDegree[v]++;
            }
        }

        if (org.size() != seen.size()) return false;

        queue<int> q;
        for (auto& [num, _] : seen) {
            if (inDegree.find(num) == inDegree.end()) {
                q.push(num);
            }
        }

        vector<int> result;
        while (!q.empty()) {
            if (q.size() > 1) return false;
            int u = q.front();
            q.pop();
            result.push_back(u);

            for (int v : adj[u]) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        if (result.size() != seen.size()) return false;

        return result == org;
    }
};