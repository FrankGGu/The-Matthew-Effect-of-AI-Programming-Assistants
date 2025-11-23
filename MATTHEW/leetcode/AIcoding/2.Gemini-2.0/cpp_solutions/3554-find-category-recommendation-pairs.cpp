#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<vector<string>> findPairs(vector<vector<string>>& products) {
        unordered_map<string, unordered_set<int>> categoryToProduct;
        for (int i = 0; i < products.size(); ++i) {
            for (const string& category : products[i]) {
                categoryToProduct[category].insert(i);
            }
        }

        vector<vector<string>> result;
        unordered_set<long long> seen;

        for (auto it1 = categoryToProduct.begin(); it1 != categoryToProduct.end(); ++it1) {
            for (auto it2 = next(it1); it2 != categoryToProduct.end(); ++it2) {
                unordered_set<int> intersection;
                for (int productIndex : it1->second) {
                    if (it2->second.count(productIndex)) {
                        intersection.insert(productIndex);
                    }
                }

                if (intersection.size() >= 2) {
                    long long hashValue = min(hash<string>()(it1->first), hash<string>()(it2->first)) * 1000000007LL +
                                          max(hash<string>()(it1->first), hash<string>()(it2->first));

                    if (seen.find(hashValue) == seen.end()) {
                        result.push_back({it1->first, it2->first});
                        seen.insert(hashValue);
                    }
                }
            }
        }

        return result;
    }
};