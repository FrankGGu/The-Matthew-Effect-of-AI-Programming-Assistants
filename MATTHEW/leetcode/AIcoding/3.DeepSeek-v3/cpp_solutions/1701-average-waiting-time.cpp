class Solution {
public:
    double averageWaitingTime(vector<vector<int>>& customers) {
        double total_waiting_time = 0;
        int current_time = 0;

        for (const auto& customer : customers) {
            int arrival = customer[0];
            int time_needed = customer[1];

            current_time = max(current_time, arrival) + time_needed;
            total_waiting_time += current_time - arrival;
        }

        return total_waiting_time / customers.size();
    }
};