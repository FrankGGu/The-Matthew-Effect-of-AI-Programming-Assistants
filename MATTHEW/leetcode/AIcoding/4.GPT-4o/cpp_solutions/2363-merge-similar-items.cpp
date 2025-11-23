#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

vector<vector<int>> mergeSimilarItems(vector<vector<int>>& items1, vector<vector<int>>& items2) {
    unordered_map<int, int> itemMap;

    for (const auto& item : items1) {
        itemMap[item[0]] += item[1];
    }

    for (const auto& item : items2) {
        itemMap[item[0]] += item[1];
    }

    vector<vector<int>> result;
    for (const auto& [key, value] : itemMap) {
        result.push_back({key, value});
    }

    sort(result.begin(), result.end());
    return result;
}