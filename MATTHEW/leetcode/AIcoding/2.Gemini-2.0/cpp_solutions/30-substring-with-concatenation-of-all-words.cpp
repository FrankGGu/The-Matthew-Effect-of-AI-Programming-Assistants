#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> findSubstring(string s, vector<string>& words) {
        vector<int> result;
        if (s.empty() || words.empty()) {
            return result;
        }

        int word_len = words[0].length();
        int num_words = words.size();
        int total_len = word_len * num_words;

        if (s.length() < total_len) {
            return result;
        }

        unordered_map<string, int> word_count;
        for (const string& word : words) {
            word_count[word]++;
        }

        for (int i = 0; i <= (int)s.length() - total_len; ++i) {
            unordered_map<string, int> seen_words;
            int j = 0;
            for (; j < num_words; ++j) {
                string word = s.substr(i + j * word_len, word_len);
                if (word_count.find(word) != word_count.end()) {
                    seen_words[word]++;
                    if (seen_words[word] > word_count[word]) {
                        break;
                    }
                } else {
                    break;
                }
            }

            if (j == num_words) {
                result.push_back(i);
            }
        }

        return result;
    }
};