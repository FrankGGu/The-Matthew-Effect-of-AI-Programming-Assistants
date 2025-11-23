class Solution {
public:
    double averageWaitingTime(vector<vector<int>>& customers) {
        long long totalWaitingTime = 0;
        long long currentTime = 0;

        for (const auto& customer : customers) {
            int arrivalTime = customer[0];
            int timeNeeded = customer[1];

            if (currentTime < arrivalTime) {
                currentTime = arrivalTime;
            }
            currentTime += timeNeeded;
            totalWaitingTime += currentTime - arrivalTime;
        }

        return static_cast<double>(totalWaitingTime) / customers.size();
    }
};