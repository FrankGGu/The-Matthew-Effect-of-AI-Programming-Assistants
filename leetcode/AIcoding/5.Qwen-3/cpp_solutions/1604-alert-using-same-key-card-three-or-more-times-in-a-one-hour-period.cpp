#include <iostream>
#include <vector>
#include <map>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> alertNames(vector<string>& keyName, vector<string>& keyTime) {
        map<string, vector<int>> timeMap;
        for (int i = 0; i < keyName.size(); ++i) {
            int hours = stoi(keyTime[i].substr(0, 2));
            int minutes = stoi(keyTime[i].substr(3, 2));
            int totalMinutes = hours * 60 + minutes;
            timeMap[keyName[i]].push_back(totalMinutes);
        }

        vector<string> result;
        for (auto& [name, times] : timeMap) {
            sort(times.begin(), times.end());
            for (int i = 2; i < times.size(); ++i) {
                if (times[i] - times[i - 2] <= 60) {
                    result.push_back(name);
                    break;
                }
            }
        }

        return result;
    }
};