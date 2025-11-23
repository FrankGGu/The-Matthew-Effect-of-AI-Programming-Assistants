class Solution {
public:
    int calPoints(vector<string>& operations) {
        stack<int> scores;
        for (const string& op : operations) {
            if (op == "+") {
                int top = scores.top();
                scores.pop();
                int newTop = top + scores.top();
                scores.push(top);
                scores.push(newTop);
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