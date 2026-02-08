#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> oddEvenTransactions(vector<vector<int>>& transactions) {
        map<int, vector<int>> odd;
        map<int, vector<int>> even;

        for (const auto& t : transactions) {
            int id = t[0];
            int amount = t[1];
            if (id % 2 == 1) {
                odd[id].push_back(amount);
            } else {
                even[id].push_back(amount);
            }
        }

        vector<vector<int>> result;
        for (const auto& pair : odd) {
            int id = pair.first;
            for (int amount : pair.second) {
                result.push_back({id, amount});
            }
        }
        for (const auto& pair : even) {
            int id = pair.first;
            for (int amount : pair.second) {
                result.push_back({id, amount});
            }
        }

        return result;
    }
};