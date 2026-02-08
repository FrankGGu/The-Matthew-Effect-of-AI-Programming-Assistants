#include <vector>
#include <string>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    vector<string> alertNames(vector<string>& keyName, vector<string>& keyTime) {
        map<string, vector<int>> nameToTimes;
        for (int i = 0; i < keyName.size(); ++i) {
            string name = keyName[i];
            string time = keyTime[i];
            int hour = stoi(time.substr(0, 2));
            int minute = stoi(time.substr(3, 2));
            nameToTimes[name].push_back(hour * 60 + minute);
        }

        vector<string> result;
        for (auto& [name, times] : nameToTimes) {
            sort(times.begin(), times.end());
            for (int i = 0; i < times.size() - 2; ++i) {
                if (times[i + 2] - times[i] <= 60) {
                    result.push_back(name);
                    break;
                }
            }
        }

        sort(result.begin(), result.end());
        result.erase(unique(result.begin(), result.end()), result.end());

        return result;
    }
};