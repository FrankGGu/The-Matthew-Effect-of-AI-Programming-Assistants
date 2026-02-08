class Solution {
public:
    vector<string> twoEditWords(vector<string>& queries, vector<string>& dictionary) {
        vector<string> result;
        for (const string& query : queries) {
            for (const string& word : dictionary) {
                if (isWithinTwoEdits(query, word)) {
                    result.push_back(query);
                    break;
                }
            }
        }
        return result;
    }

    bool isWithinTwoEdits(const string& a, const string& b) {
        if (a.size() != b.size()) return false;
        int count = 0;
        for (int i = 0; i < a.size(); ++i) {
            if (a[i] != b[i]) {
                count++;
                if (count > 2) return false;
            }
        }
        return count <= 2;
    }
};