#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> highAccessEmployees(vector<string>& access_times) {
        unordered_map<string, vector<int>> nameToTimes;
        for (const string& time : access_times) {
            string name = time.substr(0, time.find(' '));
            int hour = stoi(time.substr(time.find(' ') + 1, 2));
            int minute = stoi(time.substr(time.find(' ') + 4, 2));
            int totalMinutes = hour * 60 + minute;
            nameToTimes[name].push_back(totalMinutes);
        }

        vector<string> result;
        for (auto& [name, times] : nameToTimes) {
            sort(times.begin(), times.end());
            for (int i = 0; i <= times.size() - 3; ++i) {
                if (times[i + 2] - times[i] < 100) {
                    result.push_back(name);
                    break;
                }
            }
        }

        return result;
    }
};