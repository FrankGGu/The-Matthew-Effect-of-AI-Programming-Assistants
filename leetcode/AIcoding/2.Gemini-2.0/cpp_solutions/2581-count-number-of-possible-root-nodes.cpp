#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int rootCount(vector<vector<int>>& edges, int guesses_size, vector<vector<int>>& guesses) {
        int n = edges.size() + 1;
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        unordered_set<long long> guess_set;
        for (auto& guess : guesses) {
            guess_set.insert(((long long)guess[0] << 32) | guess[1]);
        }

        int correct_guesses = 0;
        function<void(int, int)> dfs1 = [&](int u, int parent) {
            for (int v : adj[u]) {
                if (v != parent) {
                    if (guess_set.count(((long long)u << 32) | v)) {
                        correct_guesses++;
                    }
                    dfs1(v, u);
                }
            }
        };

        dfs1(0, -1);
        int initial_correct_guesses = correct_guesses;

        int ans = 0;
        function<void(int, int, int)> dfs2 = [&](int u, int parent, int prev_correct_guesses) {
            if (prev_correct_guesses >= guesses_size) {
                ans++;
            }

            for (int v : adj[u]) {
                if (v != parent) {
                    int new_correct_guesses = prev_correct_guesses;
                    if (guess_set.count(((long long)u << 32) | v)) {
                        new_correct_guesses--;
                    }
                    if (guess_set.count(((long long)v << 32) | u)) {
                        new_correct_guesses++;
                    }
                    dfs2(v, u, new_correct_guesses);
                }
            }
        };

        dfs2(0, -1, initial_correct_guesses);

        return ans;
    }
};