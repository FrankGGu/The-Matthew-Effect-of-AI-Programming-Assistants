#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<string> removeInvalidParentheses(string s) {
        vector<string> result;
        unordered_set<string> visited;
        queue<string> q;
        bool found = false;

        q.push(s);
        visited.insert(s);

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                string current = q.front();
                q.pop();

                if (isValid(current)) {
                    result.push_back(current);
                    found = true;
                }

                if (found) continue;

                for (int j = 0; j < current.length(); ++j) {
                    if (current[j] != '(' && current[j] != ')') continue;
                    string next = current.substr(0, j) + current.substr(j + 1);
                    if (visited.find(next) == visited.end()) {
                        visited.insert(next);
                        q.push(next);
                    }
                }
            }
            if (found) break;
        }

        return result;
    }

private:
    bool isValid(string s) {
        int count = 0;
        for (char c : s) {
            if (c == '(') ++count;
            else if (c == ')') {
                --count;
                if (count < 0) return false;
            }
        }
        return count == 0;
    }
};