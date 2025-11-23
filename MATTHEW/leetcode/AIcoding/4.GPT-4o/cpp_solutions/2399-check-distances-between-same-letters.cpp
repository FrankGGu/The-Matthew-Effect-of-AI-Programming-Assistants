class Solution {
public:
    bool checkDistances(string s, vector<int>& distance) {
        vector<int> lastIndex(26, -1);
        for (int i = 0; i < s.size(); ++i) {
            int idx = s[i] - 'a';
            if (lastIndex[idx] == -1) {
                lastIndex[idx] = i;
            } else {
                if (i - lastIndex[idx] - 1 != distance[idx]) {
                    return false;
                }
            }
        }
        return true;
    }
};