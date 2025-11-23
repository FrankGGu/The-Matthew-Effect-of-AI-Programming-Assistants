#include <iostream>
#include <vector>
#include <unordered_map>
#include <utility>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<pair<int, int>> findCategoryRecommendationPairs(vector<int>& categories) {
        unordered_map<int, vector<int>> categoryIndices;
        for (int i = 0; i < categories.size(); ++i) {
            categoryIndices[categories[i]].push_back(i);
        }

        vector<pair<int, int>> result;
        for (const auto& [category, indices] : categoryIndices) {
            for (int i = 0; i < indices.size(); ++i) {
                for (int j = i + 1; j < indices.size(); ++j) {
                    result.emplace_back(indices[i], indices[j]);
                }
            }
        }

        return result;
    }
};