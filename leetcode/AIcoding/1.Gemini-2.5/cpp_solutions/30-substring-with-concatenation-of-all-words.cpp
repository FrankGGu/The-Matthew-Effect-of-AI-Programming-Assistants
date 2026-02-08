#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    std::vector<int> findSubstring(std::string s, std::vector<std::string>& words) {
        std::vector<int> result;
        if (s.empty() || words.empty()) {
            return result;
        }

        int word_len = words[0].length();
        int num_words = words.size();
        int total_len = word_len * num_words;

        if (s.length() < total_len) {
            return result;
        }

        std::unordered_map<std::string, int> word_counts;
        for (const std::string& word : words) {
            word_counts[word]++;
        }

        for (int i = 0; i < word_len; ++i) {
            int left = i;
            int count = 0; 
            std::unordered_map<std::string, int> current_window_counts;

            for (int j = i; j <= (int)s.length() - word_len; j += word_len) {
                std::string sub_word = s.substr(j, word_len);

                if (word_counts.count(sub_word)) {
                    current_window_counts[sub_word]++;
                    count++;

                    while (current_window_counts[sub_word] > word_counts[sub_word]) {
                        std::string left_word = s.substr(left, word_len);
                        current_window_counts[left_word]--;
                        count--;
                        left += word_len;
                    }

                    if (count == num_words) {
                        result.push_back(left);

                        std::string left_word = s.substr(left, word_len);
                        current_window_counts[left_word]--;
                        count--;
                        left += word_len;
                    }
                } else {
                    current_window_counts.clear();
                    count = 0;
                    left = j + word_len; 
                }
            }
        }

        return result;
    }
};