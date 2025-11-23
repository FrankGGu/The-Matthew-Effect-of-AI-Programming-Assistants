#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> findCategoryRecommendationPairs(vector<vector<string>>& userItem, vector<vector<string>>& itemCategory) {
        unordered_map<string, unordered_set<string>> userToItems;
        unordered_map<string, unordered_set<string>> itemToCategories;
        unordered_map<string, unordered_set<string>> userToCategories;

        for (const auto& entry : userItem) {
            string user = entry[0];
            string item = entry[1];
            userToItems[user].insert(item);
        }

        for (const auto& entry : itemCategory) {
            string item = entry[0];
            string category = entry[1];
            itemToCategories[item].insert(category);
        }

        for (const auto& userEntry : userToItems) {
            string user = userEntry.first;
            for (const string& item : userEntry.second) {
                if (itemToCategories.count(item)) {
                    for (const string& category : itemToCategories[item]) {
                        userToCategories[user].insert(category);
                    }
                }
            }
        }

        unordered_map<string, unordered_set<string>> categoryPairs;
        for (const auto& userEntry : userToCategories) {
            vector<string> categories(userEntry.second.begin(), userEntry.second.end());
            sort(categories.begin(), categories.end());
            for (int i = 0; i < categories.size(); ++i) {
                for (int j = i + 1; j < categories.size(); ++j) {
                    string pair = categories[i] + "," + categories[j];
                    categoryPairs[pair].insert(userEntry.first);
                }
            }
        }

        vector<vector<string>> result;
        for (const auto& pairEntry : categoryPairs) {
            if (pairEntry.second.size() >= 3) {
                size_t commaPos = pairEntry.first.find(',');
                string c1 = pairEntry.first.substr(0, commaPos);
                string c2 = pairEntry.first.substr(commaPos + 1);
                result.push_back({c1, c2, to_string(pairEntry.second.size())});
            }
        }

        sort(result.begin(), result.end(), [](const vector<string>& a, const vector<string>& b) {
            if (a[2] != b[2]) {
                return stoi(a[2]) > stoi(b[2]);
            } else if (a[0] != b[0]) {
                return a[0] < b[0];
            } else {
                return a[1] < b[1];
            }
        });

        return result;
    }
};