class Solution {
public:
    vector<string> spellchecker(vector<string>& wordlist, vector<string>& queries) {
        unordered_set<string> wordSet(wordlist.begin(), wordlist.end());
        unordered_map<string, string> capitalizationMap;
        unordered_map<string, string> vowelMap;
        vector<string> result;

        for (const string& word : wordlist) {
            string lowerWord = word;
            transform(lowerWord.begin(), lowerWord.end(), lowerWord.begin(), ::tolower);
            if (capitalizationMap.find(lowerWord) == capitalizationMap.end()) {
                capitalizationMap[lowerWord] = word;
            }

            string vowelWord = lowerWord;
            for (char& c : vowelWord) {
                if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                    c = '*';
                }
            }
            if (vowelMap.find(vowelWord) == vowelMap.end()) {
                vowelMap[vowelWord] = word;
            }
        }

        for (const string& query : queries) {
            if (wordSet.count(query)) {
                result.push_back(query);
            } else {
                string lowerQuery = query;
                transform(lowerQuery.begin(), lowerQuery.end(), lowerQuery.begin(), ::tolower);
                if (capitalizationMap.count(lowerQuery)) {
                    result.push_back(capitalizationMap[lowerQuery]);
                } else {
                    string vowelQuery = lowerQuery;
                    for (char& c : vowelQuery) {
                        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                            c = '*';
                        }
                    }
                    if (vowelMap.count(vowelQuery)) {
                        result.push_back(vowelMap[vowelQuery]);
                    } else {
                        result.push_back("");
                    }
                }
            }
        }
        return result;
    }
};