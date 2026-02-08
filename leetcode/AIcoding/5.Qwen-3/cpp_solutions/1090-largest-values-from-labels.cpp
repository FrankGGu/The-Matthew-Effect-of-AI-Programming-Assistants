#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> largestValuesFromLabels(vector<int>& values, vector<int>& labels, int numChoose) {
        vector<pair<int, int>> items;
        for (int i = 0; i < values.size(); ++i) {
            items.push_back({values[i], labels[i]});
        }

        sort(items.begin(), items.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.first > b.first;
        });

        unordered_map<int, int> labelCount;
        vector<int> result;
        for (const auto& item : items) {
            if (labelCount[item.second] < 1) {
                result.push_back(item.first);
                labelCount[item.second]++;
                if (result.size() == numChoose) break;
            }
        }

        return result;
    }
};