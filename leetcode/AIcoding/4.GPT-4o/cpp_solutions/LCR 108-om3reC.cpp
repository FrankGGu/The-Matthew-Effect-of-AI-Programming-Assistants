#include <unordered_set>
#include <string>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int ladderLength(string beginWord, string endWord, vector<string>& wordList) {
        unordered_set<string> wordSet(wordList.begin(), wordList.end());
        if (wordSet.find(endWord) == wordSet.end()) return 0;

        queue<string> q;
        q.push(beginWord);
        int length = 1;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; i++) {
                string word = q.front();
                q.pop();

                if (word == endWord) return length;

                for (int j = 0; j < word.size(); j++) {
                    char original = word[j];
                    for (char c = 'a'; c <= 'z'; c++) {
                        if (c == original) continue;
                        word[j] = c;
                        if (wordSet.find(word) != wordSet.end()) {
                            q.push(word);
                            wordSet.erase(word);
                        }
                    }
                    word[j] = original;
                }
            }
            length++;
        }
        return 0;
    }
};