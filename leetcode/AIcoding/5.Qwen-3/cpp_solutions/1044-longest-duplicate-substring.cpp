#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <numeric>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string longestDupSubstring(string s) {
        int n = s.size();
        vector<int> rank(n), next_rank(n);
        vector<int> sa(n), lcp(n);

        for (int i = 0; i < n; ++i) sa[i] = i;
        sort(sa.begin(), sa.end(), [&](int a, int b) { return s[a] < s[b]; });

        for (int i = 0; i < n; ++i) rank[sa[i]] = i;

        int k = 0;
        while (k < n) {
            for (int i = 0; i < n; ++i) {
                next_rank[i] = i == 0 || rank[sa[i - 1]] != rank[sa[i]] || rank[sa[i - 1] + k] != rank[sa[i] + k] ? i : next_rank[i - 1];
            }
            rank = next_rank;
            if (rank[sa[n - 1]] == n - 1) break;
            for (int i = 0; i < n; ++i) sa[i] = i;
            sort(sa.begin(), sa.end(), [&](int a, int b) { return rank[a] < rank[b] || (rank[a] == rank[b] && rank[a + k] < rank[b + k]); });
            k *= 2;
        }

        int max_len = 0, start = 0;
        for (int i = 0; i < n; ++i) {
            if (lcp[i] > max_len) {
                max_len = lcp[i];
                start = sa[i];
            }
        }
        return s.substr(start, max_len);
    }
};