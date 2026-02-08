#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>

using namespace std;

vector<string> alertNames(vector<string>& keyName, vector<string>& keyTime) {
    unordered_map<string, vector<int>> timeMap;
    vector<string> result;

    for (int i = 0; i < keyName.size(); ++i) {
        int hours = stoi(keyTime[i].substr(0, 2));
        int minutes = stoi(keyTime[i].substr(3, 2));
        timeMap[keyName[i]].push_back(hours * 60 + minutes);
    }

    for (const auto& entry : timeMap) {
        string name = entry.first;
        vector<int>& times = entry.second;
        sort(times.begin(), times.end());

        for (int i = 0; i < times.size(); ++i) {
            if (i >= 2 && times[i] - times[i - 2] <= 60) {
                result.push_back(name);
                break;
            }
        }
    }

    sort(result.begin(), result.end());
    return result;
}