#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <utility>

using namespace std;

class Solution {
private:
    unordered_map<string, pair<int, int>> checkInMap;
    unordered_map<string, pair<int, int>> routeMap;

public:
    void checkIn(int id, string stationName, int t) {
        checkInMap[id] = {t, 0};
    }

    void checkOut(int id, string stationName, int t) {
        auto& checkInData = checkInMap[id];
        int startTime = checkInData.first;
        string routeKey = stationName + "," + to_string(checkInData.first);
        routeMap[routeKey].first += t - startTime;
        routeMap[routeKey].second += 1;
    }

    double getAverageTime(string startStation, string endStation, int t) {
        string routeKey = endStation + "," + to_string(t);
        return static_cast<double>(routeMap[routeKey].first) / routeMap[routeKey].second;
    }
};