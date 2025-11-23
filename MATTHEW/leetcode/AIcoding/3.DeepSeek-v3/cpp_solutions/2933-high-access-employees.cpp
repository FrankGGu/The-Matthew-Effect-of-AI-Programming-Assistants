#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> findHighAccessEmployees(vector<vector<string>>& access_times) {
        unordered_map<string, vector<int>> mp;
        for (auto& entry : access_times) {
            string name = entry[0];
            string time = entry[1];
            int minutes = stoi(time.substr(0, 2)) * 60 + stoi(time.substr(2, 2));
            mp[name].push_back(minutes);
        }

        vector<string> result;
        for (auto& [name, times] : mp) {
            sort(times.begin(), times.end());
            bool found = false;
            for (int i = 0; i + 2 < times.size(); ++i) {
                if (times[i + 2] - times[i] < 60) {
                    found = true;
                    break;
                }
            }
            if (found) {
                result.push_back(name);
            }
        }

        return result;
    }
};