#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    string destCity(vector<vector<string>>& paths) {
        unordered_set<string> starts;
        unordered_set<string> ends;

        for (const auto& path : paths) {
            starts.insert(path[0]);
            ends.insert(path[1]);
        }

        for (const string& city : ends) {
            if (starts.find(city) == starts.end()) {
                return city;
            }
        }

        return "";
    }
};