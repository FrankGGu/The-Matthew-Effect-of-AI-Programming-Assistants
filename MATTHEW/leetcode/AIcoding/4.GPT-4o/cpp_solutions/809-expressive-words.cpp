class Solution {
public:
    bool isStretchy(const string& S, const string& W) {
        int i = 0, j = 0;
        int n = S.size(), m = W.size();

        while (i < n && j < m) {
            if (S[i] != W[j]) return false;

            int countS = 0, countW = 0;
            char currentChar = S[i];

            while (i < n && S[i] == currentChar) {
                countS++;
                i++;
            }
            while (j < m && W[j] == currentChar) {
                countW++;
                j++;
            }

            if (countS < countW || (countS < 3 && countS != countW)) return false;
        }

        return i == n && j == m;
    }

    int expressiveWords(string S, vector<string>& words) {
        int count = 0;
        for (const string& W : words) {
            if (isStretchy(S, W)) count++;
        }
        return count;
    }
};