class Solution {
public:
    bool pyramidTransition(string bottom, vector<string>& allowed) {
        unordered_map<string, unordered_set<char>> m;
        for (const string& s : allowed) {
            m[s.substr(0, 2)].insert(s[2]);
        }
        return canBuild(bottom, m);
    }

    bool canBuild(string bottom, unordered_map<string, unordered_set<char>>& m) {
        if (bottom.size() == 1) return true;
        vector<string> nextLevel;

        for (size_t i = 0; i < bottom.size() - 1; ++i) {
            string pair = bottom.substr(i, 2);
            if (m.find(pair) == m.end()) return false;

            for (char c : m[pair]) {
                if (nextLevel.size() <= i) nextLevel.push_back("");
                nextLevel[i] += c;
            }
        }

        for (const string& next : nextLevel) {
            if (canBuild(next, m)) return true;
        }

        return false;
    }
};