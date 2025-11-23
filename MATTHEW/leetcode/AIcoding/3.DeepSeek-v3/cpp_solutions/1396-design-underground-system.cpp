class UndergroundSystem {
private:
    unordered_map<int, pair<string, int>> checkIns;
    unordered_map<string, pair<double, int>> travelTimes;

public:
    UndergroundSystem() {

    }

    void checkIn(int id, string stationName, int t) {
        checkIns[id] = {stationName, t};
    }

    void checkOut(int id, string stationName, int t) {
        auto checkIn = checkIns[id];
        checkIns.erase(id);
        string route = checkIn.first + "_" + stationName;
        travelTimes[route].first += t - checkIn.second;
        travelTimes[route].second += 1;
    }

    double getAverageTime(string startStation, string endStation) {
        string route = startStation + "_" + endStation;
        auto time = travelTimes[route];
        return time.first / time.second;
    }
};