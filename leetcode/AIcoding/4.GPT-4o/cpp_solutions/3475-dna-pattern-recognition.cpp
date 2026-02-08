class Solution {
public:
    vector<string> findRepeatedDnaSequences(string s) {
        unordered_map<string, int> seen;
        vector<string> result;
        for (int i = 0; i + 10 <= s.size(); ++i) {
            string seq = s.substr(i, 10);
            if (++seen[seq] == 2) {
                result.push_back(seq);
            }
        }
        return result;
    }
};