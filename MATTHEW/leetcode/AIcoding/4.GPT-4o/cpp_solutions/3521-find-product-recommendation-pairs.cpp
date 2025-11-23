#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>

using namespace std;

vector<vector<int>> findPairs(vector<vector<int>>& products) {
    unordered_map<int, unordered_set<int>> productMap;
    vector<vector<int>> result;

    for (const auto& product : products) {
        int id = product[0];
        for (int i = 1; i < product.size(); ++i) {
            productMap[product[i]].insert(id);
        }
    }

    for (const auto& [key, ids] : productMap) {
        vector<int> idList(ids.begin(), ids.end());
        sort(idList.begin(), idList.end());
        for (int i = 0; i < idList.size(); ++i) {
            for (int j = i + 1; j < idList.size(); ++j) {
                result.push_back({idList[i], idList[j]});
            }
        }
    }

    return result;
}