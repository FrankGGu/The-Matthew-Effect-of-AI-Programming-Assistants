#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string smallestStringWithSwaps(string s, vector<vector<int>>& pairs) {
        int n = s.length();
        vector<int> parent(n);
        for (int i = 0; i < n; ++i) {
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

        for (const auto& pair : pairs) {
            unite(pair[0], pair[1]);
        }

        vector<vector<int>> components(n);
        for (int i = 0; i < n; ++i) {
            components[find(i)].push_back(i);
        }

        for (auto& component : components) {
            if (!component.empty()) {
                string chars;
                for (int index : component) {
                    chars += s[index];
                }
                sort(chars.begin(), chars.end());
                sort(component.begin(), component.end());
                for (size_t i = 0; i < component.size(); ++i) {
                    s[component[i]] = chars[i];
                }
            }
        }

        return s;
    }
};