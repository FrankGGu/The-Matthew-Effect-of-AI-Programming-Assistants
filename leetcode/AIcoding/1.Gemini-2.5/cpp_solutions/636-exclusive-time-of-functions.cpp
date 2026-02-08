#include <vector>
#include <string>
#include <stack>
#include <algorithm>

class Solution {
public:
    std::vector<int> exclusiveTime(int n, std::vector<std::string>& logs) {
        std::vector<int> result(n, 0);
        std::stack<int> s; // Stores function IDs
        int prev_time = 0;

        for (const std::string& log : logs) {
            // Parse the log string
            size_t first_colon = log.find(':');
            size_t second_colon = log.find(':', first_colon + 1);

            int id = std::stoi(log.substr(0, first_colon));
            std::string status = log.substr(first_colon + 1, second_colon - (first_colon + 1));
            int timestamp = std::stoi(log.substr(second_colon + 1));

            if (status == "start") {
                if (!s.empty()) {
                    // A function was running, add its exclusive time segment
                    result[s.top()] += timestamp - prev_time;
                }
                s.push(id);
                prev_time = timestamp;
            } else { // status == "end"
                // The function that just ended was running
                result[s.top()] += timestamp - prev_time + 1;
                s.pop();
                prev_time = timestamp + 1; // Update prev_time for the next event, accounting for the current function's full duration
            }
        }

        return result;
    }
};