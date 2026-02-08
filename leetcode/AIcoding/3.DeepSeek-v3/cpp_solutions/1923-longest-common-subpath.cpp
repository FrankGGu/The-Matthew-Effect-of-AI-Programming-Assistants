class Solution {
public:
    using ll = long long;
    const ll mod1 = 1e9 + 7;
    const ll mod2 = 1e9 + 9;
    const ll base = 1e5 + 3;

    int longestCommonSubpath(int n, vector<vector<int>>& paths) {
        int left = 1, right = min_element(paths.begin(), paths.end(), 
            [](const vector<int>& a, const vector<int>& b) { return a.size() < b.size(); })->size();
        int res = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (check(paths, mid)) {
                res = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return res;
    }

    bool check(vector<vector<int>>& paths, int len) {
        auto getRollingHash = [](const vector<int>& path, int len, ll mod) {
            ll hash = 0, power = 1;
            unordered_map<ll, vector<int>> hashMap;
            for (int i = 0; i < len; ++i) {
                hash = (hash * base + path[i]) % mod;
                power = (power * base) % mod;
            }
            hashMap[hash].push_back(0);
            for (int i = len; i < path.size(); ++i) {
                hash = (hash * base - path[i - len] * power % mod + path[i] + mod) % mod;
                hashMap[hash].push_back(i - len + 1);
            }
            return hashMap;
        };

        auto hashMap1 = getRollingHash(paths[0], len, mod1);
        auto hashMap2 = getRollingHash(paths[0], len, mod2);

        for (int k = 1; k < paths.size(); ++k) {
            unordered_map<ll, vector<int>> newHash1, newHash2;
            auto currentHash1 = getRollingHash(paths[k], len, mod1);
            auto currentHash2 = getRollingHash(paths[k], len, mod2);

            for (auto& [h, posList] : currentHash1) {
                if (hashMap1.count(h)) {
                    for (int pos : posList) {
                        ll h2 = 0;
                        for (int i = pos; i < pos + len; ++i) {
                            h2 = (h2 * base + paths[k][i]) % mod2;
                        }
                        if (hashMap2.count(h2)) {
                            newHash1[h].push_back(pos);
                            newHash2[h2].push_back(pos);
                        }
                    }
                }
            }

            if (newHash1.empty()) return false;
            hashMap1 = move(newHash1);
            hashMap2 = move(newHash2);
        }
        return true;
    }
};