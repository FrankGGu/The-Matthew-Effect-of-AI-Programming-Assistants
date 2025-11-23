using namespace std;

class Solution {
public:
    string mostCommonWord(string paragraph, vector<string>& banned) {
        unordered_set<string> ban_set;
        for (string s : banned) {
            string temp = "";
            for (char c : s) {
                temp += tolower(c);
            }
            ban_set.insert(temp);
        }

        unordered_map<string, int> count;
        string word = "";
        for (int i = 0; i < paragraph.size(); i++) {
            char c = paragraph[i];
            if (isalpha(c)) {
                word += tolower(c);
            } else {
                if (!word.empty()) {
                    if (ban_set.find(word) == ban_set.end()) {
                        count[word]++;
                    }
                    word = "";
                }
            }
        }
        if (!word.empty()) {
            if (ban_set.find(word) == ban_set.end()) {
                count[word]++;
            }
        }

        int max_count = 0;
        string res = "";
        for (auto& kv : count) {
            if (kv.second > max_count) {
                max_count = kv.second;
                res = kv.first;
            }
        }
        return res;
    }
};