class Solution {
public:
    string findLexSmallestString(string s, int a, int b) {
        string res = s;
        int n = s.size();
        unordered_set<string> visited;
        queue<string> q;
        q.push(s);
        visited.insert(s);

        while (!q.empty()) {
            string curr = q.front();
            q.pop();
            if (curr < res) {
                res = curr;
            }
            string next = curr;
            for (int i = 0; i < n; ++i) {
                next[i] = '0' + (curr[i] - '0' + a) % 10;
            }
            if (visited.find(next) == visited.end()) {
                visited.insert(next);
                q.push(next);
            }
            next = curr;
            reverse(next.begin(), next.end());
            for (int i = 0; i < n; ++i) {
                next[i] = '0' + (curr[i] - '0' + a) % 10;
            }
            reverse(next.begin(), next.end());
            if (visited.find(next) == visited.end()) {
                visited.insert(next);
                q.push(next);
            }
        }

        return res;
    }
};