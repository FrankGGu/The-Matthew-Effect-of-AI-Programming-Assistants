#include <string>
#include <unordered_map>
#include <utility>

class UndergroundSystem {
public:
    UndergroundSystem() {

    }

    void checkIn(int id, std::string stationName, int t) {
        customerCheckIns[id] = {stationName, t};
    }

    void checkOut(int id, std::string stationName, int t) {
        auto& checkInInfo = customerCheckIns[id];
        std::string startStation = checkInInfo.first;
        int checkInTime = checkInInfo.second;

        int travelTime = t - checkInTime;

        stationTravelTimes[startStation][stationName].first += travelTime;
        stationTravelTimes[startStation][stationName].second++;
    }

    double getAverageTime(std::string startStation, std::string endStation) {
        auto& travelData = stationTravelTimes[startStation][endStation];
        long long totalTime = travelData.first;
        int count = travelData.second;

        return static_cast<double>(totalTime) / count;
    }

private:
    std::unordered_map<int, std::pair<std::string, int>> customerCheckIns;
    std::unordered_map<std::string, std::unordered_map<std::string, std::pair<long long, int>>> stationTravelTimes;
};