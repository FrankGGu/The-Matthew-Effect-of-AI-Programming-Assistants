#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findLatestGroup(vector<int>& arr, int m) {
        int n = arr.size();
        vector<int> parent(n + 1);
        vector<int> size(n + 1, 1);

        for (int i = 0; i <= n; ++i) {
            parent[i] = i;
        }

        auto find = [&](int x) {
            while (parent[x] != x) {
                parent[x] = parent[parent[x]];
                x = parent[x];
            }
            return x;
        };

        auto unionSet = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX == rootY) return;
            if (size[rootX] < size[rootY]) {
                swap(rootX, rootY);
            }
            parent[rootY] = rootX;
            size[rootX] += size[rootY];
        };

        unordered_map<int, int> count;
        int result = -1;

        for (int i = 0; i < n; ++i) {
            int pos = arr[i];
            count[size[find(pos)]]--;
            if (count[size[find(pos)]] == 0) {
                count.erase(size[find(pos)]);
            }

            if (pos - 1 >= 0 && arr[i - 1] == pos - 1) {
                unionSet(pos, pos - 1);
            }
            if (pos + 1 <= n && arr[i + 1] == pos + 1) {
                unionSet(pos, pos + 1);
            }

            int root = find(pos);
            count[size[root]]++;

            if (count.find(m) != count.end()) {
                result = i + 1;
            }
        }

        return result;
    }
};