#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestCommonSubpath(int n, vector<vector<int>>& paths) {
        int low = 1, high = paths[0].size();
        for (auto& path : paths) {
            high = min(high, (int)path.size());
        }

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(paths, mid, n)) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return high;
    }

private:
    bool check(vector<vector<int>>& paths, int len, int n) {
        long long p = 101, mod = 1e9 + 7;
        long long p_pow = 1;
        for (int i = 0; i < len; ++i) {
            p_pow = (p_pow * p) % mod;
        }

        vector<unordered_set<long long>> path_hashes;
        for (auto& path : paths) {
            unordered_set<long long> hashes;
            long long h = 0;
            for (int i = 0; i < len; ++i) {
                h = (h * p + path[i] + 1) % mod;
            }
            hashes.insert(h);

            for (int i = len; i < path.size(); ++i) {
                h = (h - (path[i - len] + 1) * p_pow % mod + mod) % mod;
                h = (h * p + path[i] + 1) % mod;
                hashes.insert(h);
            }
            path_hashes.push_back(hashes);
        }

        unordered_set<long long> first_path_hashes = path_hashes[0];
        for (long long hash : first_path_hashes) {
            bool common = true;
            for (int i = 1; i < paths.size(); ++i) {
                if (path_hashes[i].find(hash) == path_hashes[i].end()) {
                    common = false;
                    break;
                }
            }
            if (common) {
                return true;
            }
        }

        return false;
    }
};