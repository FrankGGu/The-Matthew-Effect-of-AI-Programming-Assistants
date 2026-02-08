class Solution {
public:
    long long minimumCost(string source, string target, vector<string>& original, vector<string>& changed, vector<int>& cost) {
        unordered_map<string, int> strToId;
        int id = 0;
        auto getId = [&](const string& s) {
            if (!strToId.count(s)) {
                strToId[s] = id++;
            }
            return strToId[s];
        };

        for (int i = 0; i < original.size(); ++i) {
            getId(original[i]);
            getId(changed[i]);
        }

        int n = id;
        vector<vector<long long>> dist(n, vector<long long>(n, LLONG_MAX / 2));
        for (int i = 0; i < n; ++i) {
            dist[i][i] = 0;
        }

        for (int i = 0; i < original.size(); ++i) {
            int u = getId(original[i]);
            int v = getId(changed[i]);
            dist[u][v] = min(dist[u][v], (long long)cost[i]);
        }

        for (int k = 0; k < n; ++k) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                    }
                }
            }
        }

        int m = source.size();
        vector<long long> dp(m + 1, LLONG_MAX / 2);
        dp[0] = 0;

        for (int i = 0; i < m; ++i) {
            if (source[i] == target[i]) {
                dp[i + 1] = min(dp[i + 1], dp[i]);
            }
            for (int j = i; j < m; ++j) {
                string s = source.substr(i, j - i + 1);
                string t = target.substr(i, j - i + 1);
                if (strToId.count(s) && strToId.count(t)) {
                    int u = strToId[s];
                    int v = strToId[t];
                    if (dist[u][v] < LLONG_MAX / 2) {
                        dp[j + 1] = min(dp[j + 1], dp[i] + dist[u][v]);
                    }
                }
            }
        }

        return dp[m] == LLONG_MAX / 2 ? -1 : dp[m];
    }
};