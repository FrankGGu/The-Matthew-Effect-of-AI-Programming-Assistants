#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>

using namespace std;

vector<int> findSubstring(string s, vector<string>& words) {
    vector<int> result;
    if (s.empty() || words.empty()) return result;

    int wordLen = words[0].size();
    int totalWordsLen = wordLen * words.size();
    unordered_map<string, int> wordCount;

    for (const string& word : words) {
        wordCount[word]++;
    }

    for (int i = 0; i <= (int)s.size() - totalWordsLen; i++) {
        unordered_map<string, int> seenWords;
        int j = 0;
        while (j < words.size()) {
            string word = s.substr(i + j * wordLen, wordLen);
            if (wordCount.find(word) == wordCount.end()) break;
            seenWords[word]++;
            if (seenWords[word] > wordCount[word]) break;
            j++;
        }
        if (j == words.size()) result.push_back(i);
    }

    return result;
}