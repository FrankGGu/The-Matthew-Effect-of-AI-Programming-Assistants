class Solution {
public:
    int numMatchingSubsequences(string s, std::vector<std::string>& words) {
        std::vector<std::pair<int, const std::string*>> waiting_for[26]; 

        for (const std::string& word : words) {
            if (!word.empty()) { // Problem constraints state word length >= 1
                waiting_for[word[0] - 'a'].push_back({1, &word});
            }
        }

        int count = 0;

        for (char c : s) {
            std::vector<std::pair<int, const std::string*>> current_char_waitlist = waiting_for[c - 'a'];

            waiting_for[c - 'a'].clear();

            for (auto& p : current_char_waitlist) {
                int word_idx = p.first;
                const std::string* word_ptr = p.second;

                if (word_idx == word_ptr->length()) {
                    count++;
                } else {
                    waiting_for[(*word_ptr)[word_idx] - 'a'].push_back({word_idx + 1, word_ptr});
                }
            }
        }

        return count;
    }
};