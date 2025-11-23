class Solution {
public:
    int largestComponentSize(vector<int>& A) {
        int max_val = *max_element(A.begin(), A.end());
        vector<int> parent(max_val + 1, 0);
        iota(parent.begin(), parent.end(), 0);

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        function<void(int, int)> union_sets = [&](int x, int y) {
            parent[find(x)] = find(y);
        };

        for (int num : A) {
            for (int j = 2; j * j <= num; ++j) {
                if (num % j == 0) {
                    union_sets(num, j);
                    union_sets(num, num / j);
                }
            }
        }

        unordered_map<int, int> size;
        for (int num : A) {
            size[find(num)]++;
        }

        return max_element(size.begin(), size.end(), [](const auto& a, const auto& b) {
            return a.second < b.second;
        })->second;
    }
};