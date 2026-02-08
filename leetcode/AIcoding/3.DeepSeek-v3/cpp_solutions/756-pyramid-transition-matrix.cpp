class Solution {
public:
    bool pyramidTransition(string bottom, vector<string>& allowed) {
        unordered_map<string, vector<char>> map;
        for (string s : allowed) {
            string key = s.substr(0, 2);
            map[key].push_back(s[2]);
        }
        return dfs(bottom, map);
    }

    bool dfs(string bottom, unordered_map<string, vector<char>>& map) {
        if (bottom.size() == 1) return true;
        for (int i = 0; i < bottom.size() - 1; ++i) {
            string key = bottom.substr(i, 2);
            if (map.find(key) == map.end()) {
                return false;
            }
        }
        vector<string> next;
        generateNext(bottom, 0, "", next, map);
        for (string s : next) {
            if (dfs(s, map)) return true;
        }
        return false;
    }

    void generateNext(string bottom, int index, string current, vector<string>& next, unordered_map<string, vector<char>>& map) {
        if (index == bottom.size() - 1) {
            next.push_back(current);
            return;
        }
        string key = bottom.substr(index, 2);
        for (char c : map[key]) {
            generateNext(bottom, index + 1, current + c, next, map);
        }
    }
};