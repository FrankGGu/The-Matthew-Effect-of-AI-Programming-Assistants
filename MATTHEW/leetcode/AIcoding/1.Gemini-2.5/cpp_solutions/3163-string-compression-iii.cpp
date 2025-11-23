#include <string>
#include <algorithm> // Required for std::min

class Solution {
public:
    std::string compressedString(std::string word) {
        std::string result = "";
        int n = word.length();
        int i = 0;

        while (i < n) {
            char current_char = word[i];
            int j = i;

            while (j < n && word[j] == current_char) {
                j++;
            }
            int total_count = j - i;

            if (total_count == 1) {
                result += current_char;
            } else if (total_count == 2) {
                result += current_char;
                result += current_char;
            } else { // total_count >= 3
                while (total_count > 0) {
                    int chunk_count = std::min(total_count, 9);
                    result += current_char;
                    result += std::to_string(chunk_count);
                    total_count -= chunk_count;
                }
            }

            i = j;
        }

        return result;
    }
};