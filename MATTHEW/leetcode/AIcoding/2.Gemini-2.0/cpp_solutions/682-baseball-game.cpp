#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    int calPoints(vector<string>& ops) {
        stack<int> scores;
        for (const string& op : ops) {
            if (op == "+") {
                int top1 = scores.top();
                scores.pop();
                int top2 = scores.top();
                scores.push(top1);
                scores.push(top1 + top2);
            } else if (op == "D") {
                scores.push(2 * scores.top());
            } else if (op == "C") {
                scores.pop();
            } else {
                scores.push(stoi(op));
            }
        }

        int sum = 0;
        while (!scores.empty()) {
            sum += scores.top();
            scores.pop();
        }

        return sum;
    }
};