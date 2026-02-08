#include <vector>

using namespace std;

class Solution {
public:
    double averageWaitingTime(vector<vector<int>>& customers) {
        long long total_waiting_time = 0;
        long long current_time = 0;
        for (auto& customer : customers) {
            int arrival_time = customer[0];
            int service_time = customer[1];
            if (arrival_time > current_time) {
                current_time = arrival_time;
            }
            total_waiting_time += (current_time - arrival_time + service_time);
            current_time += service_time;
        }
        return (double)total_waiting_time / customers.size();
    }
};