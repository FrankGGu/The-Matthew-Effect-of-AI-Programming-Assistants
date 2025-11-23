#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> suggestedProducts(vector<string>& products, string searchWord) {
        sort(products.begin(), products.end());
        vector<vector<string>> result;
        string prefix = "";
        for (char c : searchWord) {
            prefix += c;
            vector<string> suggestions;
            for (string& product : products) {
                if (product.find(prefix) == 0 && suggestions.size() < 3) {
                    suggestions.push_back(product);
                }
            }
            result.push_back(suggestions);
        }
        return result;
    }
};