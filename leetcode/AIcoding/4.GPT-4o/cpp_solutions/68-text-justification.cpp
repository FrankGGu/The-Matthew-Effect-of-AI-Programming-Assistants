#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> fullJustify(vector<string>& words, int maxWidth) {
        vector<string> result;
        int n = words.size();
        int i = 0;

        while (i < n) {
            int j = i, lineLength = 0;

            while (j < n && lineLength + words[j].size() + (j - i) <= maxWidth) {
                lineLength += words[j].size();
                j++;
            }

            int numWords = j - i;
            string line;

            if (numWords == 1 || j == n) {
                for (int k = i; k < j; k++) {
                    line += words[k];
                    if (k < j - 1) line += ' ';
                }
                line += string(maxWidth - line.size(), ' ');
            } else {
                int spaces = maxWidth - lineLength;
                int spaceBetweenWords = spaces / (numWords - 1);
                int extraSpaces = spaces % (numWords - 1);

                for (int k = i; k < j; k++) {
                    line += words[k];
                    if (k < j - 1) {
                        line += string(spaceBetweenWords + (k - i < extraSpaces ? 1 : 0), ' ');
                    }
                }
            }

            result.push_back(line);
            i = j;
        }

        return result;
    }
};