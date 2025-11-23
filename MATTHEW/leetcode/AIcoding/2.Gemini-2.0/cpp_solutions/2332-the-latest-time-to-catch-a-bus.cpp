#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int latestTimeCatchTheBus(vector<int>& buses, vector<int>& passengers, int capacity) {
        sort(buses.begin(), buses.end());
        sort(passengers.begin(), passengers.end());

        int passengerIndex = 0;
        int lastPossibleTime = 0;

        for (int bus : buses) {
            int currentCapacity = capacity;
            while (passengerIndex < passengers.size() && passengers[passengerIndex] <= bus && currentCapacity > 0) {
                passengerIndex++;
                currentCapacity--;
            }

            if (currentCapacity > 0) {
                lastPossibleTime = bus;
            } else {
                lastPossibleTime = passengers[passengerIndex - 1] - 1;
            }
        }

        while (true) {
            bool found = false;
            for (int i = 0; i < passengers.size(); ++i) {
                if (passengers[i] == lastPossibleTime) {
                    lastPossibleTime--;
                    found = true;
                    break;
                }
            }
            if (!found) {
                break;
            }
        }

        return lastPossibleTime;
    }
};