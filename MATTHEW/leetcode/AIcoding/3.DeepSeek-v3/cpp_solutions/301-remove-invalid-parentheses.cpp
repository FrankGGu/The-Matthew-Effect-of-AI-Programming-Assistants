class Solution {
public:
    vector<string> removeInvalidParentheses(string s) {
        vector<string> res;
        unordered_set<string> visited;
        queue<string> q;
        q.push(s);
        visited.insert(s);
        bool found = false;

        while (!q.empty()) {
            string current = q.front();
            q.pop();

            if (isValid(current)) {
                res.push_back(current);
                found = true;
            }

            if (found) continue;

            for (int i = 0; i < current.size(); ++i) {
                if (current[i] != '(' && current[i] != ')') continue;
                string next = current.substr(0, i) + current.substr(i + 1);
                if (!visited.count(next)) {
                    visited.insert(next);
                    q.push(next);
                }
            }
        }

        return res;
    }

private:
    bool isValid(const string& s) {
        int balance = 0;
        for (char c : s) {
            if (c == '(') {
                balance++;
            } else if (c == ')') {
                balance--;
                if (balance < 0) return false;
            }
        }
        return balance == 0;
    }
};