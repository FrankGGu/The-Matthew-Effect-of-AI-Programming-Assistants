#include <vector>
#include <string>

class Solution {
public:
    std::vector<int> compute_lps(const std::string& pattern) {
        int m = pattern.length();
        std::vector<int> lps(m, 0);
        int length = 0;
        int i = 1;
        while (i < m) {
            if (pattern[i] == pattern[length]) {
                length++;
                lps[i] = length;
                i++;
            } else {
                if (length != 0) {
                    length = lps[length - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps;
    }

    std::vector<int> find_occurrences(const std::string& text, const std::string& pattern) {
        std::vector<int> occurrences;
        if (pattern.empty()) {
            return occurrences;
        }
        if (text.empty() || pattern.length() > text.length()) {
            return occurrences;
        }

        std::vector<int> lps = compute_lps(pattern);
        int n = text.length();
        int m = pattern.length();
        int i = 0;
        int j = 0;

        while (i < n) {
            if (pattern[j] == text[i]) {
                i++;
                j++;
            }
            if (j == m) {
                occurrences.push_back(i - j);
                j = lps[j - 1];
            } else if (i < n && pattern[j] != text[i]) {
                if (j != 0) {
                    j = lps[j - 1];
                } else {
                    i++;
                }
            }
        }
        return occurrences;
    }

    std::vector<int> beautifulIndices(std::string s, std::string a, std::string b, int k) {
        std::vector<int> indices_a = find_occurrences(s, a);
        std::vector<int> indices_b = find_occurrences(s, b);

        std::vector<int> result;
        int ptr_b = 0;

        for (int i_a : indices_a) {
            while (ptr_b < indices_b.size() && indices_b[ptr_b] < i_a - k) {
                ptr_b++;
            }

            if (ptr_b < indices_b.size() && indices_b[ptr_b] <= i_a + k) {
                result.push_back(i_a);
            }
        }

        return result;
    }
};