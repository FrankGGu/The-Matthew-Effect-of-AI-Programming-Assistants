class Solution {
public:
    vector<string> findWords(vector<string>& words) {
        vector<string> result;
        unordered_set<char> rows[3] = {
            {'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'},
            {'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'},
            {'z', 'x', 'c', 'v', 'b', 'n', 'm'}
        };

        for (const string& word : words) {
            char firstChar = tolower(word[0]);
            int rowIndex = -1;
            for (int i = 0; i < 3; ++i) {
                if (rows[i].count(firstChar)) {
                    rowIndex = i;
                    break;
                }
            }
            if (rowIndex != -1) {
                bool isValid = true;
                for (char c : word) {
                    if (!rows[rowIndex].count(tolower(c))) {
                        isValid = false;
                        break;
                    }
                }
                if (isValid) {
                    result.push_back(word);
                }
            }
        }
        return result;
    }
};