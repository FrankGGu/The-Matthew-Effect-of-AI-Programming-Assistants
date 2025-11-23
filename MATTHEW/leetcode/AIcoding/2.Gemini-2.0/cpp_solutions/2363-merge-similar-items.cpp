#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> mergeSimilarItems(vector<vector<int>>& items1, vector<vector<int>>& items2) {
        map<int, int> itemMap;
        for (auto& item : items1) {
            itemMap[item[0]] += item[1];
        }
        for (auto& item : items2) {
            itemMap[item[0]] += item[1];
        }

        vector<vector<int>> result;
        for (auto& entry : itemMap) {
            result.push_back({entry.first, entry.second});
        }

        return result;
    }
};