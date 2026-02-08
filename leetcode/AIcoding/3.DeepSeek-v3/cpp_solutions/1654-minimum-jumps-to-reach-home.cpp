class Solution {
public:
    int minimumJumps(vector<int>& forbidden, int a, int b, int x) {
        unordered_set<int> forbidden_set(forbidden.begin(), forbidden.end());
        queue<pair<int, bool>> q; // {position, is_backward}
        q.push({0, false});
        unordered_set<string> visited;
        visited.insert("0,false");
        int jumps = 0;
        int max_limit = 2000 + 2 * max(a, b); // To cover possible positions

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto current = q.front();
                q.pop();
                int pos = current.first;
                bool is_backward = current.second;

                if (pos == x) {
                    return jumps;
                }

                // Forward jump
                int next_pos = pos + a;
                string key = to_string(next_pos) + ",false";
                if (next_pos <= max_limit && forbidden_set.find(next_pos) == forbidden_set.end() && visited.find(key) == visited.end()) {
                    visited.insert(key);
                    q.push({next_pos, false});
                }

                // Backward jump (only if previous jump was not backward)
                if (!is_backward) {
                    next_pos = pos - b;
                    key = to_string(next_pos) + ",true";
                    if (next_pos >= 0 && forbidden_set.find(next_pos) == forbidden_set.end() && visited.find(key) == visited.end()) {
                        visited.insert(key);
                        q.push({next_pos, true});
                    }
                }
            }
            jumps++;
        }
        return -1;
    }
};