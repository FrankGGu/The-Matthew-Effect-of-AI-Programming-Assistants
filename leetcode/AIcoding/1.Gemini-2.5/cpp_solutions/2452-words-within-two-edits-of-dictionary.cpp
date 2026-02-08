class Solution {
public:
    std::vector<std::string> twoEditWords(std::vector<std::string>& queries, std::vector<std::string>& dictionary) {
        std::vector<std::string> result;
        for (const std::string& query_word : queries) {
            bool found_match_for_query = false;
            for (const std::string& dict_word : dictionary) {
                if (query_word.length() != dict_word.length()) {
                    continue;
                }

                int diff_count = 0;
                for (int i = 0; i < query_word.length(); ++i) {
                    if (query_word[i] != dict_word[i]) {
                        diff_count++;
                    }
                }

                if (diff_count <= 2) {
                    result.push_back(query_word);
                    found_match_for_query = true;
                    break; 
                }
            }
        }
        return result;
    }
};