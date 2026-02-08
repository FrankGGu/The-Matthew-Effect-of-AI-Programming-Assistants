#include <iostream>
#include <vector>
#include <stack>
#include <utility>

using namespace std;

class Solution {
public:
    vector<int> exclusiveTime(int n, vector<string>& logs) {
        vector<int> result(n, 0);
        stack<pair<int, int>> st;
        int prev_time = 0;

        for (string& log : logs) {
            size_t pos1 = log.find(':');
            size_t pos2 = log.find(':', pos1 + 1);
            int id = stoi(log.substr(0, pos1));
            string type = log.substr(pos1 + 1, pos2 - pos1 - 1);
            int time = stoi(log.substr(pos2 + 1));

            if (type == "start") {
                if (!st.empty()) {
                    result[st.top().first] += time - prev_time;
                }
                st.push({id, time});
                prev_time = time;
            } else {
                int start_id = st.top().first;
                result[start_id] += time - prev_time + 1;
                st.pop();
                prev_time = time + 1;
            }
        }

        return result;
    }
};