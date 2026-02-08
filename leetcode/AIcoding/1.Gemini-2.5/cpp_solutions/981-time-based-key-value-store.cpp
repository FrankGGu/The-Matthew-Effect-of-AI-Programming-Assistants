#include <string>
#include <vector>
#include <unordered_map>
#include <utility>
#include <algorithm>

class TimeMap {
public:
    TimeMap() {
    }

    void set(std::string key, std::string value, int timestamp) {
        store[key].push_back({timestamp, value});
    }

    std::string get(std::string key, int timestamp) {
        if (store.find(key) == store.end()) {
            return "";
        }

        const auto& pairs = store.at(key);

        auto it = std::upper_bound(pairs.begin(), pairs.end(), timestamp, 
                                   [](int ts, const std::pair<int, std::string>& p) {
            return ts < p.first;
        });

        if (it == pairs.begin()) {
            return "";
        }

        return std::prev(it)->second;
    }

private:
    std::unordered_map<std::string, std::vector<std::pair<int, std::string>>> store;
};