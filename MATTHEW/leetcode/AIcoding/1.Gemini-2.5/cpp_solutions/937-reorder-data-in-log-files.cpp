#include <vector>
#include <string>
#include <algorithm>
#include <cctype>

class Solution {
public:
    std::vector<std::string> reorderLogFiles(std::vector<std::string>& logs) {
        std::vector<std::string> letter_logs;
        std::vector<std::string> digit_logs;

        for (const std::string& log : logs) {
            size_t first_space_idx = log.find(' ');
            if (isdigit(log[first_space_idx + 1])) {
                digit_logs.push_back(log);
            } else {
                letter_logs.push_back(log);
            }
        }

        std::sort(letter_logs.begin(), letter_logs.end(), [](const std::string& log1, const std::string& log2) {
            size_t first_space_idx1 = log1.find(' ');
            std::string content1 = log1.substr(first_space_idx1 + 1);
            std::string identifier1 = log1.substr(0, first_space_idx1);

            size_t first_space_idx2 = log2.find(' ');
            std::string content2 = log2.substr(first_space_idx2 + 1);
            std::string identifier2 = log2.substr(0, first_space_idx2);

            if (content1 != content2) {
                return content1 < content2;
            }
            return identifier1 < identifier2;
        });

        letter_logs.insert(letter_logs.end(), digit_logs.begin(), digit_logs.end());

        return letter_logs;
    }
};