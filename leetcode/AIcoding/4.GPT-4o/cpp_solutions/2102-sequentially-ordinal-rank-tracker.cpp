class SORTracker {
public:
    SORTracker() {}

    void add(string name, int score) {
        records.emplace_back(score, name);
        sort(records.begin(), records.end(), [](const auto& a, const auto& b) {
            return a.first == b.first ? a.second < b.second : a.first > b.first;
        });
    }

    string get() {
        return records[index++].second;
    }

private:
    vector<pair<int, string>> records;
    int index = 0;
};