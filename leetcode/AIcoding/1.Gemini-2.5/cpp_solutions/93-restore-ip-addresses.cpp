#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    bool isValid(const std::string& s) {
        if (s.length() == 0 || s.length() > 3) {
            return false;
        }
        if (s.length() > 1 && s[0] == '0') {
            return false;
        }
        int num = std::stoi(s);
        return num >= 0 && num <= 255;
    }

    void backtrack(const std::string& s, int start_index, std::vector<std::string>& current_parts, std::vector<std::string>& result) {
        if (current_parts.size() == 4) {
            if (start_index == s.length()) {
                std::string ip = current_parts[0];
                for (int i = 1; i < 4; ++i) {
                    ip += "." + current_parts[i];
                }
                result.push_back(ip);
            }
            return;
        }

        int remaining_chars = s.length() - start_index;
        int remaining_segments = 4 - current_parts.size();
        if (remaining_chars < remaining_segments || remaining_chars > remaining_segments * 3) {
            return;
        }

        for (int length = 1; length <= 3; ++length) {
            if (start_index + length > s.length()) {
                break;
            }

            std::string segment = s.substr(start_index, length);
            if (isValid(segment)) {
                current_parts.push_back(segment);
                backtrack(s, start_index + length, current_parts, result);
                current_parts.pop_back();
            }
        }
    }

    std::vector<std::string> restoreIpAddresses(std::string s) {
        std::vector<std::string> result;
        std::vector<std::string> current_parts;

        if (s.length() < 4 || s.length() > 12) {
            return result;
        }

        backtrack(s, 0, current_parts, result);
        return result;
    }
};