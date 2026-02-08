class Solution {
public:
    int countCoveredBuildings(vector<vector<int>>& buildings) {
        vector<pair<int, int>> events; // (position, type)
        for (const auto& b : buildings) {
            events.emplace_back(b[0], 1); // start of building
            events.emplace_back(b[1], -1); // end of building
        }

        sort(events.begin(), events.end());

        int count = 0, activeBuildings = 0, lastPosition = -1;

        for (const auto& event : events) {
            if (activeBuildings > 0 && lastPosition != -1) {
                count += event.first - lastPosition;
            }
            activeBuildings += event.second;
            lastPosition = event.first;
        }

        return count;
    }
};