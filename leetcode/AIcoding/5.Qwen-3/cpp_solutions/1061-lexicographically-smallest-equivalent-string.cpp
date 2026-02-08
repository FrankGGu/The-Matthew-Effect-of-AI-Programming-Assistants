#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string smallestEquivalentString(string A, string B, string S) {
        vector<int> parent(26);
        for (int i = 0; i < 26; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            return parent[x] == x ? x : parent[x] = find(parent[x]);
        };

        function<void(int, int)> unite = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
            }
        };

        for (int i = 0; i < A.size(); ++i) {
            unite(A[i] - 'a', B[i] - 'a');
        }

        string result;
        for (char c : S) {
            result += (find(c - 'a') + 'a');
        }

        return result;
    }
};