class Solution {
public:
    vector<string> spellchecker(vector<string>& wordlist, vector<string>& queries) {
        unordered_set<string> exactMatch;
        unordered_map<string, string> caseInsensitive;
        unordered_map<string, string> vowelError;

        for (string word : wordlist) {
            exactMatch.insert(word);

            string lowerWord = toLower(word);
            if (caseInsensitive.find(lowerWord) == caseInsensitive.end()) {
                caseInsensitive[lowerWord] = word;
            }

            string vowelRemoved = removeVowels(lowerWord);
            if (vowelError.find(vowelRemoved) == vowelError.end()) {
                vowelError[vowelRemoved] = word;
            }
        }

        vector<string> result;
        for (string query : queries) {
            if (exactMatch.find(query) != exactMatch.end()) {
                result.push_back(query);
                continue;
            }

            string lowerQuery = toLower(query);
            if (caseInsensitive.find(lowerQuery) != caseInsensitive.end()) {
                result.push_back(caseInsensitive[lowerQuery]);
                continue;
            }

            string vowelRemovedQuery = removeVowels(lowerQuery);
            if (vowelError.find(vowelRemovedQuery) != vowelError.end()) {
                result.push_back(vowelError[vowelRemovedQuery]);
                continue;
            }

            result.push_back("");
        }

        return result;
    }

private:
    string toLower(string s) {
        for (char &c : s) {
            c = tolower(c);
        }
        return s;
    }

    string removeVowels(string s) {
        for (char &c : s) {
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                c = '#';
            }
        }
        return s;
    }
};