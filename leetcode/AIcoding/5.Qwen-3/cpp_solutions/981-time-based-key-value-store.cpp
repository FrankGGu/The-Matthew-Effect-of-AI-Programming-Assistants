#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    void set(std::string key, std::string value, int timestamp) {
        data[key].push_back({timestamp, value});
    }

    std::string get(std::string key, int timestamp) {
        if (data.find(key) == data.end()) {
            return "";
        }
        const auto& times = data[key];
        auto it = std::upper_bound(times.begin(), times.end(), std::make_pair(timestamp, ""));
        if (it == times.begin()) {
            return "";
        }
        return (--it)->second;
    }

private:
    std::map<std::string, std::vector<std::pair<int, std::string>>> data;
};