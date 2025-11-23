#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::string> result;
    std::string s_global;

    bool isValid(const std::string& s_part) {
        if (s_part.empty() || s_part.length() > 3) {
            return false;
        }
        if (s_part.length() > 1 && s_part[0] == '0') {
            return false;
        }
        int val = std::stoi(s_part);
        return val >= 0 && val <= 255;
    }

    void backtrack(int start_index, int segment_count, std::vector<std::string>& current_ip_parts) {
        if (segment_count == 4) {
            if (start_index == s_global.length()) {
                std::string ip = current_ip_parts[0];
                for (int i = 1; i < 4; ++i) {
                    ip += "." + current_ip_parts[i];
                }
                result.push_back(ip);
            }
            return;
        }

        // Optimization: if remaining characters are too few or too many for remaining segments
        // Each segment needs at least 1 char, at most 3 chars.
        // Min chars needed: (4 - segment_count) * 1
        // Max chars needed: (4 - segment_count) * 3
        int remaining_chars = s_global.length() - start_index;
        if (remaining_chars < (4 - segment_count) || remaining_chars > (4 - segment_count) * 3) {
            return;
        }

        // Try segments of length 1, 2, or 3
        for (int i = 1; i <= 3; ++i) {
            if (start_index + i > s_global.length()) {
                break; // Substring would go out of bounds
            }
            std::string segment = s_global.substr(start_index, i);
            if (isValid(segment)) {
                current_ip_parts.push_back(segment);
                backtrack(start_index + i, segment_count + 1, current_ip_parts);
                current_ip_parts.pop_back(); // Backtrack
            }
        }
    }

    std::vector<std::string> restoreIpAddresses(std::string s) {
        s_global = s;
        // An IP address has 4 parts, each 1-3 digits long.
        // So total length must be between 4 (e.g., "0.0.0.0") and 12 (e.g., "255.255.255.255").
        if (s.length() < 4 || s.length() > 12) {
            return {};
        }
        std::vector<std::string> current_ip_parts;
        backtrack(0, 0, current_ip_parts);
        return result;
    }
};