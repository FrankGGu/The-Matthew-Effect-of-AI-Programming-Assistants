#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> spellchecker(vector<string>& wordlist, vector<string>& queries) {
        unordered_map<string, string> map;
        unordered_map<string, string> caseMap;
        unordered_map<string, string> vowelMap;

        for (const string& word : wordlist) {
            string lower = word;
            for (char& c : lower) c = tolower(c);
            if (caseMap.find(lower) == caseMap.end()) {
                caseMap[lower] = word;
            }

            string vowel = lower;
            for (char& c : vowel) {
                if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                    c = '*';
                }
            }
            if (vowelMap.find(vowel) == vowelMap.end()) {
                vowelMap[vowel] = word;
            }

            if (map.find(word) == map.end()) {
                map[word] = word;
            }
        }

        vector<string> result;
        for (const string& q : queries) {
            string lower = q;
            for (char& c : lower) c = tolower(c);
            string vowel = lower;
            for (char& c : vowel) {
                if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                    c = '*';
                }
            }

            if (map.find(q) != map.end()) {
                result.push_back(q);
            } else if (caseMap.find(lower) != caseMap.end()) {
                result.push_back(caseMap[lower]);
            } else if (vowelMap.find(vowel) != vowelMap.end()) {
                result.push_back(vowelMap[vowel]);
            } else {
                result.push_back("");
            }
        }

        return result;
    }
};