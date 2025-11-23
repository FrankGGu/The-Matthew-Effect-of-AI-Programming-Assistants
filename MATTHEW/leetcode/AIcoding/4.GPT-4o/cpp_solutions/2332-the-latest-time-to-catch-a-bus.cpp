#include <vector>
#include <algorithm>
#include <set>

using namespace std;

int latestTimeCatchBus(vector<int>& buses, vector<int>& passengers, int capacity) {
    sort(buses.begin(), buses.end());
    sort(passengers.begin(), passengers.end());

    int i = 0, j = 0, n = buses.size(), m = passengers.size();
    set<int> caught;

    for (int b = 0; b < n; ++b) {
        int count = 0;
        while (i < m && passengers[i] <= buses[b] && count < capacity) {
            caught.insert(passengers[i]);
            ++i;
            ++count;
        }
    }

    int latestTime = 0;
    if (i > 0 && caught.size() == capacity) {
        latestTime = *prev(caught.end());
        if (latestTime == buses.back()) {
            --latestTime;
            while (caught.count(latestTime)) {
                --latestTime;
            }
        }
    } else if (i > 0) {
        latestTime = buses.back();
    } else {
        latestTime = buses[0];
    }

    return latestTime;
}