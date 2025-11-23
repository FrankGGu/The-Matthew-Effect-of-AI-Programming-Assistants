#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string replaceWords(vector<string>& dictionary, string sentence) {
        sort(dictionary.begin(), dictionary.end());
        vector<string> words;
        string word;
        for (char c : sentence) {
            if (c == ' ') {
                words.push_back(word);
                word.clear();
            } else {
                word += c;
            }
        }
        words.push_back(word);

        for (int i = 0; i < words.size(); ++i) {
            for (const string& root : dictionary) {
                if (words[i].substr(0, root.length()) == root) {
                    words[i] = root;
                    break;
                }
            }
        }

        string result;
        for (int i = 0; i < words.size(); ++i) {
            result += words[i];
            if (i != words.size() - 1) {
                result += " ";
            }
        }
        return result;
    }
};