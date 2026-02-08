#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    string destinationCity(vector<vector<string>>& paths) {
        unordered_set<string> cities;
        for (const auto& path : paths) {
            cities.insert(path[0]);
        }
        for (const auto& path : paths) {
            if (cities.find(path[1]) == cities.end()) {
                return path[1];
            }
        }
        return "";
    }
};