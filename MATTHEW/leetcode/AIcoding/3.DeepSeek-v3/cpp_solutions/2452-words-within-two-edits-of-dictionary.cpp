using namespace std;

class Solution {
public:
    vector<bool> twoEditWords(vector<string>& queries, vector<string>& dictionary) {
        vector<bool> ans;
        for (auto& query : queries) {
            bool found = false;
            for (auto& dict : dictionary) {
                int diff = 0;
                for (int i = 0; i < query.size(); i++) {
                    if (query[i] != dict[i]) {
                        diff++;
                        if (diff > 2) break;
                    }
                }
                if (diff <= 2) {
                    found = true;
                    break;
                }
            }
            ans.push_back(found);
        }
        return ans;
    }
};