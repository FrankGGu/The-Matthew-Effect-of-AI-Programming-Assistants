class Solution {
public:
    std::vector<std::string> splitWordsBySeparator(std::vector<std::string>& words, char separator) {
        std::vector<std::string> result;
        for (const std::string& word : words) {
            std::string current_substring;
            for (char c : word) {
                if (c == separator) {
                    if (!current_substring.empty()) {
                        result.push_back(current_substring);
                        current_substring.clear();
                    }
                } else {
                    current_substring += c;
                }
            }
            if (!current_substring.empty()) {
                result.push_back(current_substring);
            }
        }
        return result;
    }
};