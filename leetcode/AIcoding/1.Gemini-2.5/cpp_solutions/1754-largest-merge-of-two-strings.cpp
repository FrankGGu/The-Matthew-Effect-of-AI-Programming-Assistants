#include <string>
#include <algorithm> // Not strictly needed, but often useful

class Solution {
public:
    std::string largestMerge(std::string word1, std::string word2) {
        std::string merge = "";
        merge.reserve(word1.length() + word2.length());

        int i = 0; // Pointer for word1
        int j = 0; // Pointer for word2

        while (i < word1.length() || j < word2.length()) {
            if (i < word1.length() && j < word2.length()) {
                // Both words still have characters
                if (word1[i] > word2[j]) {
                    merge += word1[i];
                    i++;
                } else if (word2[j] > word1[i]) {
                    merge += word2[j];
                    j++;
                } else {
                    // Characters are equal, compare suffixes to break the tie
                    // Use std::string::compare for efficient suffix comparison
                    // A return value > 0 means word1's suffix is lexicographically greater.
                    // A return value <= 0 means word2's suffix is lexicographically greater or equal.
                    if (word1.compare(i, std::string::npos, word2, j, std::string::npos) > 0) {
                        merge += word1[i];
                        i++;
                    } else {
                        merge += word2[j];
                        j++;
                    }
                }
            } else if (i < word1.length()) {
                // Only word1 has remaining characters
                merge += word1[i];
                i++;
            } else { // j < word2.length()
                // Only word2 has remaining characters
                merge += word2[j];
                j++;
            }
        }

        return merge;
    }
};