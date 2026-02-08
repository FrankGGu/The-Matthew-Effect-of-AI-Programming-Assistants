#include <iostream>
#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    int calPoints(vector<string>& ops) {
        stack<int> scores;
        for (const string& op : ops) {
            if (op == "C") {
                scores.pop();
            } else if (op == "D") {
                int top = scores.top();
                scores.push(top * 2);
            } else if (op == "+") {
                int top = scores.top();
                scores.pop();
                int secondTop = scores.top();
                scores.push(secondTop + top);
                scores.push(top);
            } else {
                scores.push(stoi(op));
            }
        }
        int total = 0;
        while (!scores.empty()) {
            total += scores.top();
            scores.pop();
        }
        return total;
    }
};