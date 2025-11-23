#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int groupStrings(vector<string>& words) {
        unordered_map<int, int> parent;
        unordered_map<int, int> rank;
        int n = words.size();

        auto find = [&](auto self, int x) -> int {
            if (parent[x] != x) {
                parent[x] = self(self, parent[x]);
            }
            return parent[x];
        };

        auto unionSets = [&](int x, int y) {
            int rootX = find(find, x);
            int rootY = find(find, y);
            if (rootX != rootY) {
                if (rank[rootX] < rank[rootY]) {
                    parent[rootX] = rootY;
                } else if (rank[rootX] > rank[rootY]) {
                    parent[rootY] = rootX;
                } else {
                    parent[rootY] = rootX;
                    rank[rootX]++;
                }
            }
        };

        for (int i = 0; i < n; ++i) {
            int mask = 0;
            for (char c : words[i]) {
                mask |= (1 << (c - 'a'));
            }
            parent[mask] = mask;
            rank[mask] = 0;
        }

        for (int i = 0; i < n; ++i) {
            int mask = 0;
            for (char c : words[i]) {
                mask |= (1 << (c - 'a'));
            }

            for (int j = 0; j < 26; ++j) {
                int newMask = mask ^ (1 << j);
                if (newMask != mask && parent.count(newMask)) {
                    unionSets(mask, newMask);
                }
            }

            for (int j = 0; j < 26; ++j) {
                if ((mask & (1 << j)) == 0) continue;
                for (int k = 0; k < 26; ++k) {
                    if ((mask & (1 << k)) != 0) continue;
                    int newMask = (mask ^ (1 << j)) | (1 << k);
                    if (parent.count(newMask)) {
                        unionSets(mask, newMask);
                    }
                }
            }
        }

        int groups = 0;
        unordered_map<int, bool> visited;
        for (int i = 0; i < n; ++i) {
            int mask = 0;
            for (char c : words[i]) {
                mask |= (1 << (c - 'a'));
            }
            int root = find(find, mask);
            if (!visited[root]) {
                groups++;
                visited[root] = true;
            }
        }

        int maxSize = 0;
        unordered_map<int, int> groupSize;
        for (int i = 0; i < n; ++i) {
            int mask = 0;
            for (char c : words[i]) {
                mask |= (1 << (c - 'a'));
            }
            int root = find(find, mask);
            groupSize[root]++;
            maxSize = max(maxSize, groupSize[root]);
        }

        return {groups, maxSize};
    }
};