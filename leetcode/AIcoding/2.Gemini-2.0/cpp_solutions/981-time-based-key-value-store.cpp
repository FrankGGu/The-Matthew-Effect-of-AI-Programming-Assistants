#include <string>
#include <vector>
#include <map>

using namespace std;

class TimeMap {
public:
    TimeMap() {

    }

    void set(string key, string value, int timestamp) {
        data[key].push_back({timestamp, value});
    }

    string get(string key, int timestamp) {
        if (data.find(key) == data.end()) {
            return "";
        }

        vector<pair<int, string>>& values = data[key];
        string result = "";
        int left = 0;
        int right = values.size() - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (values[mid].first <= timestamp) {
                result = values[mid].second;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }

private:
    map<string, vector<pair<int, string>>> data;
};