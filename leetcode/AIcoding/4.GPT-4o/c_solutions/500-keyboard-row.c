class Solution {
public:
    vector<string> findWords(vector<string>& words) {
        vector<string> result;
        string rows[3] = {"qwertyuiop", "asdfghjkl", "zxcvbnm"};
        unordered_set<char> rowSet[3];

        for (int i = 0; i < 3; i++) {
            for (char c : rows[i]) {
                rowSet[i].insert(tolower(c));
            }
        }

        for (string& word : words) {
            int rowIndex = -1;
            bool valid = true;
            for (char c : word) {
                char lowerChar = tolower(c);
                if (rowIndex == -1) {
                    for (int i = 0; i < 3; i++) {
                        if (rowSet[i].count(lowerChar)) {
                            rowIndex = i;
                            break;
                        }
                    }
                } else if (!rowSet[rowIndex].count(lowerChar)) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                result.push_back(word);
            }
        }

        return result;
    }
};