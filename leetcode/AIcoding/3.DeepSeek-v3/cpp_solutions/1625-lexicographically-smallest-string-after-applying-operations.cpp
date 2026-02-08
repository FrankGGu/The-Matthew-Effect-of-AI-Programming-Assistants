class Solution {
public:
    string findLexSmallestString(string s, int a, int b) {
        unordered_set<string> visited;
        queue<string> q;
        q.push(s);
        visited.insert(s);
        string res = s;
        while (!q.empty()) {
            string curr = q.front();
            q.pop();
            if (curr < res) {
                res = curr;
            }
            string add = curr;
            for (int i = 1; i < add.size(); i += 2) {
                add[i] = ((add[i] - '0' + a) % 10) + '0';
            }
            if (visited.find(add) == visited.end()) {
                visited.insert(add);
                q.push(add);
            }
            string rotate = curr.substr(b) + curr.substr(0, b);
            if (visited.find(rotate) == visited.end()) {
                visited.insert(rotate);
                q.push(rotate);
            }
        }
        return res;
    }
};