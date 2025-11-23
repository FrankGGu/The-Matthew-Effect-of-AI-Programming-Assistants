#include <vector>
#include <queue>
#include <utility>
#include <tuple>
#include <functional>

class Solution {
public:
    std::vector<int> assignTasks(std::vector<int>& servers, std::vector<int>& tasks) {
        int num_servers = servers.size();
        int num_tasks = tasks.size();

        std::priority_queue<std::pair<int, int>,
                            std::vector<std::pair<int, int>>,
                            std::greater<std::pair<int, int>>> available_servers;

        std::priority_queue<std::tuple<long long, int, int>,
                            std::vector<std::tuple<long long, int, int>>,
                            std::greater<std::tuple<long long, int, int>>> busy_servers;

        for (int i = 0; i < num_servers; ++i) {
            available_servers.push({servers[i], i});
        }

        std::vector<int> result(num_tasks);

        for (int i = 0; i < num_tasks; ++i) {
            long long current_task_arrival_time = i;
            int task_duration = tasks[i];

            while (!busy_servers.empty() && std::get<0>(busy_servers.top()) <= current_task_arrival_time) {
                auto [free_time, weight, index] = busy_servers.top();
                busy_servers.pop();
                available_servers.push({weight, index});
            }

            int assigned_server_index;
            long long server_start_processing_time;

            if (!available_servers.empty()) {
                auto [weight, index] = available_servers.top();
                available_servers.pop();
                assigned_server_index = index;
                server_start_processing_time = current_task_arrival_time;
            } else {
                long long earliest_free_time = std::get<0>(busy_servers.top());

                while (!busy_servers.empty() && std::get<0>(busy_servers.top()) == earliest_free_time) {
                    auto [free_time, weight, index] = busy_servers.top();
                    busy_servers.pop();
                    available_servers.push({weight, index});
                }

                auto [selected_weight, selected_index] = available_servers.top();
                available_servers.pop();
                assigned_server_index = selected_index;
                server_start_processing_time = earliest_free_time;
            }

            result[i] = assigned_server_index;
            busy_servers.push({server_start_processing_time + task_duration, servers[assigned_server_index], assigned_server_index});
        }

        return result;
    }
};