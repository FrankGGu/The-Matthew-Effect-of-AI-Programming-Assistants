#include <vector>
#include <set>
#include <queue>
#include <algorithm>

class Solution {
public:
    std::vector<int> busiestServers(int k, std::vector<int>& arrival, std::vector<int>& load) {
        std::vector<int> counts(k, 0);

        std::priority_queue<std::pair<long long, int>,
                             std::vector<std::pair<long long, int>>,
                             std::greater<std::pair<long long, int>>> busy_servers;

        std::set<int> available_servers;
        for (int i = 0; i < k; ++i) {
            available_servers.insert(i);
        }

        int n = arrival.size();
        for (int i = 0; i < n; ++i) {
            long long current_arrival_time = arrival[i];
            long long current_load = load[i];

            while (!busy_servers.empty() && busy_servers.top().first <= current_arrival_time) {
                int server_id_to_free = busy_servers.top().second;
                busy_servers.pop();
                available_servers.insert(server_id_to_free);
            }

            if (available_servers.empty()) {
                continue;
            }

            int target_server_id = i % k;
            auto it = available_servers.lower_bound(target_server_id);

            int assigned_server_id;
            if (it != available_servers.end()) {
                assigned_server_id = *it;
            } else {
                assigned_server_id = *available_servers.begin();
            }

            counts[assigned_server_id]++;
            available_servers.erase(assigned_server_id);
            busy_servers.push({current_arrival_time + current_load, assigned_server_id});
        }

        int max_requests = 0;
        for (int count : counts) {
            if (count > max_requests) {
                max_requests = count;
            }
        }

        std::vector<int> result_servers;
        for (int i = 0; i < k; ++i) {
            if (counts[i] == max_requests) {
                result_servers.push_back(i);
            }
        }

        return result_servers;
    }
};