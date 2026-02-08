class Solution {
public:
    string findLexSmallestString(string s, int a, int b) {
        int n = s.length();
        string result = s;
        queue<string> q;
        unordered_set<string> visited;
        q.push(s);
        visited.insert(s);

        while (!q.empty()) {
            string curr = q.front();
            q.pop();
            if (curr < result) {
                result = curr;
            }
            // Perform addition
            string added = curr;
            for (int i = 0; i < n; i++) {
                added[i] = '0' + (curr[i] - '0' + a) % 10;
            }
            if (visited.find(added) == visited.end()) {
                visited.insert(added);
                q.push(added);
            }
            // Perform rotation
            string rotated = curr.substr(n - b) + curr.substr(0, n - b);
            if (visited.find(rotated) == visited.end()) {
                visited.insert(rotated);
                q.push(rotated);
            }
        }

        return result;
    }
};