#include <string>
#include <vector>
#include <sstream>
#include <cctype>

class Solution {
public:
    bool isValidSegment(const std::string& s) {
        if (s.empty() || s.length() > 3) {
            return false;
        }
        if (s.length() > 1 && s[0] == '0') {
            return false;
        }
        int num = 0;
        for (char c : s) {
            if (!std::isdigit(c)) {
                return false;
            }
            num = num * 10 + (c - '0');
        }
        return num >= 0 && num <= 255;
    }

    std::vector<std::string> findInvalidIPAddresses(std::string s) {
        if (s.empty()) {
            return {s};
        }

        std::stringstream ss(s);
        std::string segment;
        std::vector<std::string> segments;
        int dotCount = 0;

        // Read the first segment
        if (!std::getline(ss, segment, '.')) {
            return {s}; // Should not happen for non-empty s unless it's just a dot or malformed
        }
        segments.push_back(segment);

        // Read subsequent segments
        while (std::getline(ss, segment, '.')) {
            segments.push_back(segment);
            dotCount++;
        }

        if (dotCount != 3 || segments.size() != 4) {
            return {s};
        }

        for (const std::string& seg : segments) {
            if (!isValidSegment(seg)) {
                return {s};
            }
        }

        return {};
    }
};