#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> fullJustify(vector<string>& words, int maxWidth) {
        vector<string> result;
        int i = 0;
        while (i < words.size()) {
            int j = i;
            int len = 0;
            while (j < words.size() && len + words[j].length() + (j - i) <= maxWidth) {
                len += words[j].length();
                j++;
            }

            string line;
            int numWords = j - i;

            if (numWords == 1 || j == words.size()) {
                for (int k = i; k < j; k++) {
                    line += words[k];
                    if (k != j - 1) {
                        line += " ";
                    }
                }
                while (line.length() < maxWidth) {
                    line += " ";
                }
            } else {
                int numSpaces = maxWidth - len;
                int spacesBetween = numSpaces / (numWords - 1);
                int extraSpaces = numSpaces % (numWords - 1);

                for (int k = i; k < j; k++) {
                    line += words[k];
                    if (k != j - 1) {
                        for (int s = 0; s < spacesBetween; s++) {
                            line += " ";
                        }
                        if (extraSpaces > 0) {
                            line += " ";
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