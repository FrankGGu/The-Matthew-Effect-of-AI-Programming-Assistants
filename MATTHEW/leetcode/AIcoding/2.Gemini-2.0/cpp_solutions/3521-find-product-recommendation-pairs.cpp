#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

vector<vector<int>> findProductPairs(vector<vector<int>>& products) {
    unordered_map<int, unordered_set<int>> userProducts;
    for (int i = 0; i < products.size(); ++i) {
        for (int product : products[i]) {
            userProducts[i].insert(product);
        }
    }

    vector<vector<int>> result;
    for (int i = 0; i < products.size(); ++i) {
        for (int j = i + 1; j < products.size(); ++j) {
            int common = 0;
            for (int product : userProducts[i]) {
                if (userProducts[j].count(product)) {
                    common++;
                }
            }
            if (common >= 2) {
                result.push_back({i, j});
            }
        }
    }

    return result;
}