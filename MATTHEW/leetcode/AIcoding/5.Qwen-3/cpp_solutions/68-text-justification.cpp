#include <iostream>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

class Solution {
public:
    vector<string> fullJustify(vector<string>& words, int maxWidth) {
        vector<string> result;
        int n = words.size();
        int i = 0;
        while (i < n) {
            int j = i;
            int len = 0;
            while (j < n && len + words[j].length() + (j - i) <= maxWidth) {
                len += words[j++].length();
            }
            int space = maxWidth - len;
            int numWords = j - i;
            string line;
            if (numWords == 1) {
                line = words[i] + string(space, ' ');
            } else {
                int avgSpace = space / (numWords - 1);
                int extraSpace = space % (numWords - 1);
                for (int k = i; k < j; ++k) {
                    line += words[k];
                    if (k < j - 1) {
                        line += string(avgSpace, ' ');
                        if (extraSpace-- > 0) {
                            line += ' ';
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