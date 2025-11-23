#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> mergeSimilarItems(vector<vector<int>>& items1, vector<vector<int>>& items2) {
        map<int, int> itemMap;
        for (const auto& item : items1) {
            itemMap[item[0]] += item[1];
        }
        for (const auto& item : items2) {
            itemMap[item[0]] += item[1];
        }
        vector<vector<int>> result;
        for (const auto& pair : itemMap) {
            result.push_back({pair.first, pair.second});
        }
        return result;
    }
};