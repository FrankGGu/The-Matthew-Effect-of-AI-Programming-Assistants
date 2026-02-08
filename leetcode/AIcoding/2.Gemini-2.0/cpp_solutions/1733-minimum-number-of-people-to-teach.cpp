#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumTeachings(int n, vector<vector<int>>& languages, vector<vector<int>>& friendships) {
        vector<pair<int, int>> need_help;
        for (auto& friendship : friendships) {
            int u = friendship[0] - 1;
            int v = friendship[1] - 1;
            bool can_communicate = false;
            for (int lang_u : languages[u]) {
                for (int lang_v : languages[v]) {
                    if (lang_u == lang_v) {
                        can_communicate = true;
                        break;
                    }
                }
                if (can_communicate) break;
            }
            if (!can_communicate) {
                need_help.push_back({u, v});
            }
        }

        int min_teach = friendships.size() + 1;
        for (int lang = 1; lang <= n; ++lang) {
            unordered_set<int> people_to_teach;
            for (auto& p : need_help) {
                int u = p.first;
                int v = p.second;
                bool u_knows = false;
                bool v_knows = false;
                for (int l : languages[u]) {
                    if (l == lang) {
                        u_knows = true;
                        break;
                    }
                }
                for (int l : languages[v]) {
                    if (l == lang) {
                        v_knows = true;
                        break;
                    }
                }
                if (!u_knows) people_to_teach.insert(u);
                if (!v_knows) people_to_teach.insert(v);
            }
            min_teach = min(min_teach, (int)people_to_teach.size());
        }

        return min_teach;
    }
};