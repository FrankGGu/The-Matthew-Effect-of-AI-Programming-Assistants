#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>
#include <sstream>
#include <iomanip>

using namespace std;

class Solution {
public:
    vector<string> alertNames(vector<string>& keyName, vector<string>& keyTime) {
        unordered_map<string, vector<int>> nameToTimes;
        for (int i = 0; i < keyName.size(); ++i) {
            string time = keyTime[i];
            int hours = stoi(time.substr(0, 2));
            int minutes = stoi(time.substr(3, 2));
            int total = hours * 60 + minutes;
            nameToTimes[keyName[i]].push_back(total);
        }

        vector<string> result;
        for (auto& [name, times] : nameToTimes) {
            sort(times.begin(), times.end());
            for (int i = 2; i < times.size(); ++i) {
                if (times[i] - times[i - 2] <= 60) {
                    result.push_back(name);
                    break;
                }
            }
        }

        sort(result.begin(), result.end());
        return result;
    }
};