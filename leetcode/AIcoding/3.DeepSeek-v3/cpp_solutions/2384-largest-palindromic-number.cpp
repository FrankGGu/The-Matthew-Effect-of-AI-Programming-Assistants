class Solution {
public:
    string largestPalindromic(string num) {
        int count[10] = {0};
        for (char c : num) {
            count[c - '0']++;
        }

        string firstHalf;
        for (int i = 9; i >= 0; --i) {
            if (i == 0 && firstHalf.empty()) continue;
            while (count[i] >= 2) {
                firstHalf += ('0' + i);
                count[i] -= 2;
            }
        }

        string secondHalf = firstHalf;
        reverse(secondHalf.begin(), secondHalf.end());

        char middle = '\0';
        for (int i = 9; i >= 0; --i) {
            if (count[i] > 0) {
                middle = '0' + i;
                break;
            }
        }

        string result;
        if (middle != '\0') {
            result = firstHalf + middle + secondHalf;
        } else {
            result = firstHalf + secondHalf;
        }

        return result.empty() ? "0" : result;
    }
};