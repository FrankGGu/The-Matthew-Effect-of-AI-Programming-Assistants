#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int maxEvents(vector<vector<int>>& events) {
        sort(events.begin(), events.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] < b[0];
        });

        priority_queue<int, vector<int>, greater<int>> pq;
        int eventIndex = 0;
        int attendedEvents = 0;
        int day = 1;

        while (eventIndex < events.size() || !pq.empty()) {
            while (eventIndex < events.size() && events[eventIndex][0] == day) {
                pq.push(events[eventIndex][1]);
                eventIndex++;
            }

            while (!pq.empty() && pq.top() < day) {
                pq.pop();
            }

            if (!pq.empty()) {
                pq.pop();
                attendedEvents++;
            }

            day++;
        }

        return attendedEvents;
    }
};