
class Solution {
public:
    std::vector<std::string> findOcurrences(std::string text, std::string first, std::string second) {
        std::vector<std::string> words;
        std::istringstream iss(text);
        std::string word;
        while (iss >> word) {
            words.push_back(word);
        }

        std::vector<std::string> result;
        for (int i = 0; i < (int)words.size() - 2; ++i) {
            if (words[i] == first && words[i+1] == second) {
                result.push_back(words[i+2]);
            }
        }
        return result;
    }
};