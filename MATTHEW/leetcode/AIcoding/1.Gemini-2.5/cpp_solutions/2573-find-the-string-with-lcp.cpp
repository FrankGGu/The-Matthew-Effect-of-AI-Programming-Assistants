#include <vector>
#include <string>
#include <numeric>
#include <algorithm>

class DSU {
public:
    std::vector<int> parent;
    std::vector<int> sz; // size for union by size/rank optimization

    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0); // Initialize each element as its own parent
        sz.assign(n, 1); // Each set initially has size 1
    }

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]); // Path compression
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            // Union by size
            if (sz[root_i] < sz[root_j])
                std::swap(root_i, root_j);
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
        }
    }
};

class Solution {
public:
    std::string findTheString(std::vector<std::vector<int>>& lcp) {
        int n = lcp.size();
        if (n == 0) {
            return "";
        }

        // Step 1: Initialize DSU and group indices that must have the same character.
        // If lcp[i][j] > 0, it implies s[i] must be equal to s[j].
        DSU dsu(n);
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (lcp[i][j] > 0) {
                    dsu.unite(i, j);
                }
            }
        }

        // Step 2: Assign characters to the string based on DSU groups.
        // We assign 'a', 'b', 'c', ... to distinct DSU roots in order.
        std::string s(n, ' ');
        std::vector<char> char_map(n, ' '); // Maps DSU root (an index from 0 to n-1) to a character
        char current_char = 'a';

        for (int i = 0; i < n; ++i) {
            int root_i = dsu.find(i);
            if (char_map[root_i] == ' ') { // If this DSU root hasn't been assigned a character yet
                if (current_char > 'z') {
                    return ""; // More than 26 distinct characters needed, impossible
                }
                char_map[root_i] = current_char;
                current_char++;
            }
            s[i] = char_map[root_i];
        }

        // Step 3: Verify the generated string by computing its LCP array and comparing it
        // with the input LCP array.
        std::vector<std::vector<int>> lcp_computed(n, std::vector<int>(n, 0));

        // Compute LCP array using dynamic programming (bottom-up approach)
        for (int i = n - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                if (i == j) {
                    lcp_computed[i][j] = n - i; // LCP of a suffix with itself is its length
                } else if (s[i] == s[j]) {
                    // If s[i] == s[j], then LCP(s[i...], s[j...]) is 1 + LCP(s[i+1...], s[j+1...])
                    lcp_computed[i][j] = 1 + ((i + 1 < n && j + 1 < n) ? lcp_computed[i+1][j+1] : 0);
                } else {
                    lcp_computed[i][j] = 0; // If s[i] != s[j], LCP is 0
                }
            }
        }

        // Step 4: Compare the computed LCP array with the input LCP array
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (lcp_computed[i][j] != lcp[i][j]) {
                    return ""; // Mismatch found, the generated string is not valid
                }
            }
        }

        // If all checks pass, the generated string is a valid solution
        return s;
    }
};