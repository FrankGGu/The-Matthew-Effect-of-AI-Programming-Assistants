#include <vector>

using namespace std;

class Solution {
public:
    int countConnectedComponents(int n, int k) {
        vector<int> parent(n + 1);
        for (int i = 1; i <= n; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        auto unite = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootX] = rootY;
            }
        };

        for (int i = k; i <= n; ++i) {
            for (int j = 2 * i; j <= n; j += i) {
                if (lcm(i, j) <= n) {
                    unite(i, j);
                }
            }
        }

        int count = 0;
        for (int i = 1; i <= n; ++i) {
            if (parent[i] == i) {
                count++;
            }
        }

        return count;
    }

private:
    long long gcd(long long a, long long b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }

    long long lcm(long long a, long long b) {
        return (a * b) / gcd(a, b);
    }
};