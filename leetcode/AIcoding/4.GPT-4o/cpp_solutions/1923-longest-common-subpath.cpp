class Solution {
public:
    int mod = 1e9 + 7;
    vector<long long> power;

    void precompute(int n) {
        power.resize(n);
        power[0] = 1;
        for (int i = 1; i < n; i++) {
            power[i] = (power[i - 1] * 31) % mod;
        }
    }

    long long hash(const vector<int>& path) {
        long long h = 0;
        for (int i = 0; i < path.size(); i++) {
            h = (h * 31 + path[i]) % mod;
        }
        return h;
    }

    bool check(const vector<int>& path, int length, unordered_set<long long>& hashes) {
        long long h = hash(vector<int>(path.begin(), path.begin() + length));
        hashes.insert(h);

        for (int i = 1; i <= path.size() - length; i++) {
            h = (h * 31 - path[i - 1] * power[length] % mod + mod) % mod;
            h = (h + path[i + length - 1]) % mod;
            hashes.insert(h);
        }

        return true;
    }

    bool dfs(TreeNode* node, int length, vector<int>& path, unordered_set<long long>& hashes) {
        if (!node) return false;
        path.push_back(node->val);
        if (path.size() >= length) {
            check(path, length, hashes);
        }
        bool found = dfs(node->left, length, path, hashes) || dfs(node->right, length, path, hashes);
        path.pop_back();
        return found;
    }

    bool hasCommonSubpath(TreeNode* root, int length, unordered_set<long long>& hashes) {
        vector<int> path;
        return dfs(root, length, path, hashes);
    }

    int longestCommonSubpath(int n, vector<vector<int>>& paths) {
        int left = 1, right = 100000, answer = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            unordered_set<long long> hashes;
            bool found = true;

            for (const auto& path : paths) {
                if (!hasCommonSubpath(root, mid, hashes)) {
                    found = false;
                    break;
                }
            }

            if (found) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return answer;
    }
};