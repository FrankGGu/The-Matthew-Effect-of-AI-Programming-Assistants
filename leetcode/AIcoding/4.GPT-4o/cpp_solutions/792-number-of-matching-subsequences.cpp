class Solution {
public:
    int numMatchingSubseq(string s, vector<string>& words) {
        vector<vector<int>> charPos(26);
        for (int i = 0; i < s.size(); i++) {
            charPos[s[i] - 'a'].push_back(i);
        }

        int count = 0;
        for (const string& word : words) {
            int currentPos = -1;
            bool isSubseq = true;
            for (char c : word) {
                auto& positions = charPos[c - 'a'];
                auto it = upper_bound(positions.begin(), positions.end(), currentPos);
                if (it == positions.end()) {
                    isSubseq = false;
                    break;
                }
                currentPos = *it;
            }
            if (isSubseq) {
                count++;
            }
        }

        return count;
    }
};