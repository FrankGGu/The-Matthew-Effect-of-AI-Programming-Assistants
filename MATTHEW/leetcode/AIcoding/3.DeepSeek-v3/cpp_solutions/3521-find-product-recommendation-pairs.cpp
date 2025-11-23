#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> findProductPairs(vector<int>& products, vector<vector<int>>& purchases) {
        unordered_map<int, unordered_set<int>> productToUsers;
        unordered_map<int, unordered_set<int>> userToProducts;

        for (const auto& purchase : purchases) {
            int userId = purchase[0];
            int productId = purchase[1];
            productToUsers[productId].insert(userId);
            userToProducts[userId].insert(productId);
        }

        vector<int> uniqueProducts(products.begin(), products.end());
        sort(uniqueProducts.begin(), uniqueProducts.end());

        vector<vector<int>> result;
        int n = uniqueProducts.size();

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int a = uniqueProducts[i];
                int b = uniqueProducts[j];
                const auto& usersA = productToUsers[a];
                const auto& usersB = productToUsers[b];

                int count = 0;
                for (int user : usersA) {
                    if (usersB.find(user) != usersB.end()) {
                        count++;
                    }
                }

                if (count >= 3) {
                    result.push_back({a, b});
                }
            }
        }

        return result;
    }
};