#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string findLatestTimeToCatchABus(vector<int>& buses, vector<int>& passengers, int capacity) {
        sort(buses.begin(), buses.end());
        sort(passengers.begin(), passengers.end());

        int p = 0;
        int n = buses.size();
        int m = passengers.size();

        for (int i = 0; i < n; ++i) {
            int cap = capacity;
            while (p < m && passengers[p] <= buses[i] && cap > 0) {
                p++;
                cap--;
            }

            if (cap > 0) {
                if (i == 0) {
                    return to_string(buses[0]);
                } else {
                    int prevBus = buses[i - 1];
                    int currBus = buses[i];
                    if (passengers[p - 1] < prevBus) {
                        return to_string(currBus);
                    } else {
                        return to_string(currBus - 1);
                    }
                }
            }
        }

        return to_string(buses.back());
    }
};