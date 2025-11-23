class Solution {
public:
    string robotCollision(string commands) {
        stack<char> s;
        for (char command : commands) {
            if (command == 'R') {
                s.push(command);
            } else if (command == 'L') {
                while (!s.empty() && s.top() == 'R') {
                    s.pop();
                }
                if (s.empty() || s.top() == 'L') {
                    s.push(command);
                } else if (s.top() == 'R') {
                    s.pop();
                }
            } else {
                if (s.empty() || s.top() == 'L') {
                    s.push(command);
                } else if (s.top() == 'R') {
                    continue;
                }
            }
        }
        string result;
        while (!s.empty()) {
            result += s.top();
            s.pop();
        }
        reverse(result.begin(), result.end());
        return result;
    }
};