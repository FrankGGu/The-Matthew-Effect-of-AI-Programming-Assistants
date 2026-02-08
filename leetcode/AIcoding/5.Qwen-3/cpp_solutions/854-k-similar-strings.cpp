#include <iostream>
#include <vector>
#include <queue>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int kSimilarity(string s, string t) {
        if (s == t) return 0;

        int n = s.size();
        queue<string> q;
        q.push(s);
        unordered_map<string, int> dist;
        dist[s] = 0;

        while (!q.empty()) {
            string curr = q.front();
            q.pop();
            int d = dist[curr];

            for (int i = 0; i < n; ++i) {
                if (curr[i] != t[i]) {
                    for (int j = i + 1; j < n; ++j) {
                        if (curr[j] == t[i] && curr[i] == t[j]) {
                            swap(curr[i], curr[j]);
                            if (curr == t) return d + 1;
                            if (dist.find(curr) == dist.end()) {
                                dist[curr] = d + 1;
                                q.push(curr);
                            }
                            swap(curr[i], curr[j]);                         }
                    }
                    break;                 }
            }
        }
        return -1;
    }
};