#include <iostream>
#include <vector>
#include <string>
#include <stack>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string evaluate(string s, vector<vector<string>> &knowledge) {
        unordered_map<string, string> map;
        for (const auto &pair : knowledge) {
            map[pair[0]] = pair[1];
        }

        stack<string> stack;
        string current;

        for (char c : s) {
            if (c == '(') {
                stack.push(current);
                current = "";
            } else if (c == ')') {
                string key = current;
                current = stack.top();
                stack.pop();
                current += map[key];
            } else {
                current += c;
            }
        }

        return current;
    }
};