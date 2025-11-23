class Solution {
public:
    vector<int> exclusiveTime(int n, vector<string>& logs) {
        vector<int> result(n, 0);
        stack<int> stk;
        int prev_time = 0;

        for (const string& log : logs) {
            int pos1 = log.find(':');
            int pos2 = log.find(':', pos1 + 1);
            int id = stoi(log.substr(0, pos1));
            string state = log.substr(pos1 + 1, pos2 - pos1 - 1);
            int time = stoi(log.substr(pos2 + 1));

            if (state == "start") {
                if (!stk.empty()) {
                    result[stk.top()] += time - prev_time;
                }
                stk.push(id);
                prev_time = time;
            } else {
                result[stk.top()] += time - prev_time + 1;
                stk.pop();
                prev_time = time + 1;
            }
        }
        return result;
    }
};