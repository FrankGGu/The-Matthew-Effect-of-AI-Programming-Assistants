#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int unhappyFriends(int n, vector<vector<int>>& preferences, vector<vector<int>>& pairs) {
        unordered_map<int, int> pairMap;
        for (const auto& p : pairs) {
            pairMap[p[0]] = p[1];
            pairMap[p[1]] = p[0];
        }

        unordered_set<int> unhappy;
        for (const auto& p : pairs) {
            int a = p[0], b = p[1];
            for (int i = 0; i < preferences[a].size(); ++i) {
                int c = preferences[a][i];
                if (c == b) break;
                int d = pairMap[c];
                if (preferences[a].index_of(c) < preferences[a].index_of(d)) {
                    unhappy.insert(a);
                    break;
                }
            }
            for (int i = 0; i < preferences[b].size(); ++i) {
                int c = preferences[b][i];
                if (c == a) break;
                int d = pairMap[c];
                if (preferences[b].index_of(c) < preferences[b].index_of(d)) {
                    unhappy.insert(b);
                    break;
                }
            }
        }

        return unhappy.size();
    }
};