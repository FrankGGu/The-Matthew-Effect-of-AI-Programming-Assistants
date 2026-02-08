class Solution {
public:
    int smallestChair(vector<vector<int>>& times, int targetFriend) {
        vector<pair<int, int>> events;
        for (const auto& time : times) {
            events.emplace_back(time[0], 1); // arrival
            events.emplace_back(time[1], -1); // departure
        }

        sort(events.begin(), events.end());

        priority_queue<int, vector<int>, greater<int>> availableChairs;
        for (int i = 0; i < times.size(); ++i) {
            availableChairs.push(i);
        }

        int targetArrival = times[targetFriend][0];
        int targetDeparture = times[targetFriend][1];
        int assignedChair = -1;

        for (const auto& event : events) {
            int time = event.first;
            int type = event.second;

            while (!availableChairs.empty() && time >= times[availableChairs.top()][0]) {
                availableChairs.push(availableChairs.top());
                availableChairs.pop();
            }

            if (type == 1) {
                if (availableChairs.empty()) continue;
                int chair = availableChairs.top();
                availableChairs.pop();
                if (time == targetArrival) {
                    assignedChair = chair;
                }
            } else {
                if (time == targetDeparture && assignedChair != -1) {
                    return assignedChair;
                }
            }
        }
        return assignedChair;
    }
};