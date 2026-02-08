class TimeMap {
private:
    unordered_map<string, vector<pair<int, string>>> data;

public:
    TimeMap() {

    }

    void set(string key, string value, int timestamp) {
        data[key].emplace_back(timestamp, value);
    }

    string get(string key, int timestamp) {
        if (data.find(key) == data.end()) {
            return "";
        }
        auto& entries = data[key];
        int left = 0, right = entries.size() - 1;
        string result = "";
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (entries[mid].first <= timestamp) {
                result = entries[mid].second;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return result;
    }
};