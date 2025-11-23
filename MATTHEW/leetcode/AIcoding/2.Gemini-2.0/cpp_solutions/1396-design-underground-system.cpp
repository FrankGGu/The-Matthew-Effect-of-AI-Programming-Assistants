#include <unordered_map>
#include <string>

class UndergroundSystem {
public:
    UndergroundSystem() {

    }

    void checkIn(int id, std::string stationName, int t) {
        checkIns[id] = {stationName, t};
    }

    void checkOut(int id, std::string stationName, int t) {
        auto checkInInfo = checkIns[id];
        std::string startStation = checkInInfo.first;
        int startTime = checkInInfo.second;
        std::string route = startStation + "," + stationName;
        travelTimes[route].first += t - startTime;
        travelTimes[route].second++;
        checkIns.erase(id);
    }

    double getAverageTime(std::string startStation, std::string endStation) {
        std::string route = startStation + "," + endStation;
        return (double)travelTimes[route].first / travelTimes[route].second;
    }

private:
    std::unordered_map<int, std::pair<std::string, int>> checkIns;
    std::unordered_map<std::string, std::pair<long long, int>> travelTimes;
};