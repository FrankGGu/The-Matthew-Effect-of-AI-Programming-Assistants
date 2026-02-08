class Solution {
public:
    vector<string> findRepeatedDnaSequences(string s) {
        unordered_map<string, int> seen;
        vector<string> result;
        if (s.size() <= 10) return result;

        for (int i = 0; i <= s.size() - 10; ++i) {
            string current = s.substr(i, 10);
            seen[current]++;
            if (seen[current] == 2) {
                result.push_back(current);
            }
        }

        return result;
    }
};