#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> spellchecker(vector<string>& wordlist, vector<string>& queries) {
        unordered_set<string> exact;
        unordered_set<string> lower;
        unordered_set<string> vowel;

        for (const string& word : wordlist) {
            exact.insert(word);
        }

        vector<string> ans;
        for (const string& query : queries) {
            if (exact.count(query)) {
                ans.push_back(query);
                continue;
            }

            string lower_query = toLower(query);
            string best_match = "";

            for (const string& word : wordlist) {
                if (toLower(word) == lower_query) {
                    if (best_match == "") {
                        best_match = word;
                    }
                }
            }

            if (best_match != "") {
                ans.push_back(best_match);
                continue;
            }

            string vowel_query = replaceVowels(lower_query);
            best_match = "";

            for (const string& word : wordlist) {
                if (replaceVowels(toLower(word)) == vowel_query) {
                    if (best_match == "") {
                        best_match = word;
                    }
                }
            }

            if (best_match != "") {
                ans.push_back(best_match);
                continue;
            }

            ans.push_back("");
        }

        return ans;
    }

private:
    string toLower(const string& s) {
        string res = s;
        for (char& c : res) {
            c = tolower(c);
        }
        return res;
    }

    string replaceVowels(const string& s) {
        string res = s;
        for (char& c : res) {
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                c = '*';
            }
        }
        return res;
    }
};