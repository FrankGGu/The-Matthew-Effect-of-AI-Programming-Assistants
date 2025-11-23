#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    std::vector<int> countServers(int n, std::vector<std::vector<int>>& logs, std::vector<std::vector<int>>& queries) {
        std::sort(logs.begin(), logs.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[1] < b[1];
        });

        std::vector<std::tuple<int, int, int>> indexedQueries(queries.size());
        for (int i = 0; i < queries.size(); ++i) {
            indexedQueries[i] = std::make_tuple(queries[i][0], queries[i][1], i);
        }

        std::sort(indexedQueries.begin(), indexedQueries.end());

        std::vector<int> ans(queries.size());
        std::vector<int> server_request_counts(n + 1, 0);
        int active_servers = 0;
        int log_left_ptr = 0;
        int log_right_ptr = 0;

        for (const auto& query_tuple : indexedQueries) {
            int query_time = std::get<0>(query_tuple);
            int duration = std::get<1>(query_tuple);
            int original_index = std::get<2>(query_tuple);

            int window_start_time = query_time - duration;
            int window_end_time = query_time;

            while (log_right_ptr < logs.size() && logs[log_right_ptr][1] <= window_end_time) {
                int server_id = logs[log_right_ptr][0];
                if (server_request_counts[server_id] == 0) {
                    active_servers++;
                }
                server_request_counts[server_id]++;
                log_right_ptr++;
            }

            while (log_left_ptr < logs.size() && logs[log_left_ptr][1] < window_start_time) {
                int server_id = logs[log_left_ptr][0];
                server_request_counts[server_id]--;
                if (server_request_counts[server_id] == 0) {
                    active_servers--;
                }
                log_left_ptr++;
            }

            ans[original_index] = n - active_servers;
        }

        return ans;
    }
};