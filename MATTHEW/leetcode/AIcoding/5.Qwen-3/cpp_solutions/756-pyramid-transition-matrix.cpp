#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>

using namespace std;

class Solution {
public:
    bool pyramidTransition(string bottom, vector<string> &allowed) {
        map<char, set<char>> graph;
        for (const string &s : allowed) {
            graph[s[0]].insert(s[1]);
        }

        return dfs(bottom, graph, 0, "");
    }

private:
    bool dfs(const string &bottom, map<char, set<char>> &graph, int pos, string next) {
        if (bottom.length() == 1) {
            return true;
        }
        if (pos == bottom.length() - 1) {
            return dfs(next, graph, 0, "");
        }

        char c = bottom[pos];
        for (char nextChar : graph[c]) {
            next += nextChar;
            if (dfs(bottom, graph, pos + 1, next)) {
                return true;
            }
            next.pop_back();
        }
        return false;
    }
};