class Solution {
public:
    string capitalizeTitle(string title) {
        int n = title.size();
        for (int i = 0; i < n; ++i) {
            int start = i;
            while (i < n && title[i] != ' ') {
                title[i] = tolower(title[i]);
                ++i;
            }
            if (i - start > 2) {
                title[start] = toupper(title[start]);
            }
        }
        return title;
    }
};