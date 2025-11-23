class Solution {
public:
    int minimumTimeToInitialState(string word, int k) {
        int n = word.size();
        int res = 1;
        for (int i = k; i < n; i += k, res++) {
            bool match = true;
            for (int j = i; j < n; j++) {
                if (word[j] != word[j - i]) {
                    match = false;
                    break;
                }
            }
            if (match) {
                return res;
            }
        }
        return res;
    }
};