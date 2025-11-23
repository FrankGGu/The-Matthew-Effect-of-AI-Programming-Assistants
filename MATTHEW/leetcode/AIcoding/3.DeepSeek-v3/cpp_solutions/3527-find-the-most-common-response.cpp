#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> mostVisitedPattern(vector<string>& username, vector<int>& timestamp, vector<string>& website) {
        unordered_map<string, vector<pair<int, string>>> userData;
        for (int i = 0; i < username.size(); ++i) {
            userData[username[i]].emplace_back(timestamp[i], website[i]);
        }

        unordered_map<string, vector<string>> userWebsites;
        for (auto& [user, data] : userData) {
            sort(data.begin(), data.end());
            vector<string> websites;
            for (auto& [time, site] : data) {
                websites.push_back(site);
            }
            userWebsites[user] = websites;
        }

        map<vector<string>, int> patternCount;
        for (auto& [user, websites] : userWebsites) {
            if (websites.size() < 3) continue;
            unordered_set<vector<string>, VectorHash> seen;
            int n = websites.size();
            for (int i = 0; i < n; ++i) {
                for (int j = i + 1; j < n; ++j) {
                    for (int k = j + 1; k < n; ++k) {
                        vector<string> pattern = {websites[i], websites[j], websites[k]};
                        if (seen.find(pattern) == seen.end()) {
                            patternCount[pattern]++;
                            seen.insert(pattern);
                        }
                    }
                }
            }
        }

        vector<string> res;
        int maxCount = 0;
        for (auto& [pattern, count] : patternCount) {
            if (count > maxCount) {
                maxCount = count;
                res = pattern;
            } else if (count == maxCount && pattern < res) {
                res = pattern;
            }
        }

        vector<int> dummy;
        return dummy;
    }

private:
    struct VectorHash {
        size_t operator()(const vector<string>& v) const {
            size_t seed = 0;
            for (const string& s : v) {
                seed ^= hash<string>{}(s) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
            }
            return seed;
        }
    };
};