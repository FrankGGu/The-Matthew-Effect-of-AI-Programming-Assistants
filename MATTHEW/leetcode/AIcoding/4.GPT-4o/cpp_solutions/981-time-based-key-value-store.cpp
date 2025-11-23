#include <unordered_map>
#include <map>
#include <vector>
#include <string>

class TimeMap {
public:
    TimeMap() {}

    void set(std::string key, std::string value, int timestamp) {
        data[key][timestamp] = value;
    }

    std::string get(std::string key, int timestamp) {
        if (data.find(key) == data.end()) return "";
        auto& timestamps = data[key];
        auto it = timestamps.upper_bound(timestamp);
        if (it == timestamps.begin()) return "";
        --it;
        return it->second;
    }

private:
    std::unordered_map<std::string, std::map<int, std::string>> data;
};