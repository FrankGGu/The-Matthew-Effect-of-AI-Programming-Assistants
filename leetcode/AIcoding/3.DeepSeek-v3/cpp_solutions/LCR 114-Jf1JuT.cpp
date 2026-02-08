class Solution {
public:
    string alienOrder(vector<string>& words) {
        unordered_map<char, unordered_set<char>> graph;
        unordered_map<char, int> inDegree;

        for (auto word : words) {
            for (char c : word) {
                inDegree[c] = 0;
            }
        }

        for (int i = 0; i < words.size() - 1; ++i) {
            string curr = words[i];
            string next = words[i + 1];
            int minLen = min(curr.size(), next.size());
            bool found = false;
            for (int j = 0; j < minLen; ++j) {
                char u = curr[j];
                char v = next[j];
                if (u != v) {
                    if (graph[u].find(v) == graph[u].end()) {
                        graph[u].insert(v);
                        inDegree[v]++;
                    }
                    found = true;
                    break;
                }
            }
            if (!found && curr.size() > next.size()) {
                return "";
            }
        }

        queue<char> q;
        for (auto& entry : inDegree) {
            if (entry.second == 0) {
                q.push(entry.first);
            }
        }

        string result;
        while (!q.empty()) {
            char u = q.front();
            q.pop();
            result += u;
            for (char v : graph[u]) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return result.size() == inDegree.size() ? result : "";
    }
};