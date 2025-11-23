#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    std::vector<std::string> fullJustify(std::vector<std::string>& words, int maxWidth) {
        std::vector<std::string> result;
        int n = words.size();
        int i = 0;

        while (i < n) {
            int j = i;
            int currentLineWordsLengthSumWithMinSpaces = 0; // Sum of lengths of words[k] + (k-i) spaces for k from i to j-1
            int currentLineWordCount = 0;

            while (j < n) {
                int potentialLengthWithSpaces;
                if (currentLineWordCount == 0) {
                    potentialLengthWithSpaces = words[j].length();
                } else {
                    potentialLengthWithSpaces = currentLineWordsLengthSumWithMinSpaces + 1 + words[j].length();
                }

                if (potentialLengthWithSpaces <= maxWidth) {
                    currentLineWordsLengthSumWithMinSpaces = potentialLengthWithSpaces;
                    currentLineWordCount++;
                    j++;
                } else {
                    break;
                }
            }

            int sumOfActualWordLengths = 0;
            for (int k = i; k < j; ++k) {
                sumOfActualWordLengths += words[k].length();
            }

            std::string line;
            int totalSpacesToDistribute = maxWidth - sumOfActualWordLengths;

            if (j == n || currentLineWordCount == 1) {
                for (int k = i; k < j; ++k) {
                    line += words[k];
                    if (k < j - 1) {
                        line += ' ';
                    }
                }
                line += std::string(maxWidth - line.length(), ' ');
            } else {
                int numGaps = currentLineWordCount - 1;
                int baseSpacesPerGap = totalSpacesToDistribute / numGaps;
                int extraSpaces = totalSpacesToDistribute % numGaps;

                for (int k = i; k < j; ++k) {
                    line += words[k];
                    if (k < j - 1) {
                        line += std::string(baseSpacesPerGap, ' ');
                        if (extraSpaces > 0) {
                            line += ' ';
                            extraSpaces--;
                        }
                    }
                }
            }
            result.push_back(line);
            i = j;
        }
        return result;
    }
};