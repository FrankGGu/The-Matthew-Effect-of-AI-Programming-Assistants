#include <unordered_map>
#include <string>
#include <tuple>

class UndergroundSystem {
    struct Trip {
        std::string startStation;
        int startTime;
    };

    std::unordered_map<int, Trip> checkIns;
    std::unordered_map<std::string, std::pair<double, int>> travelData;

public:
    UndergroundSystem() {}

    void checkIn(int id, std::string stationName, int t) {
        checkIns[id] = {stationName, t};
    }

    void checkOut(int id, std::string stationName, int t) {
        auto& start = checkIns[id];
        std::string route = start.startStation + "->" + stationName;
        travelData[route].first += t - start.startTime;
        travelData[route].second++;
        checkIns.erase(id);
    }

    double getAverageTime(std::string startStation, std::string endStation) {
        std::string route = startStation + "->" + endStation;
        return travelData[route].first / travelData[route].second;
    }
};