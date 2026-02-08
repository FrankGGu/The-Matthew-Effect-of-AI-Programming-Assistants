class Solution {
public:
    vector<string> fullJustify(vector<string>& words, int maxWidth) {
        vector<string> result;
        int n = words.size();
        int i = 0;
        while (i < n) {
            int j = i, len = 0;
            while (j < n && len + words[j].size() + (j - i) <= maxWidth) {
                len += words[j].size();
                j++;
            }
            int spaces = maxWidth - len;
            int numWords = j - i;
            string line;
            if (numWords == 1 || j == n) {
                line = words[i];
                for (int k = i + 1; k < j; ++k) {
                    line += " " + words[k];
                }
                line += string(maxWidth - line.size(), ' ');
            } else {
                int spaceBetween = spaces / (numWords - 1);
                int extra = spaces % (numWords - 1);
                line = words[i];
                for (int k = i + 1; k < j; ++k) {
                    line += string(spaceBetween + (extra-- > 0 ? 1 : 0), ' ');
                    line += words[k];
                }
            }
            result.push_back(line);
            i = j;
        }
        return result;
    }
};