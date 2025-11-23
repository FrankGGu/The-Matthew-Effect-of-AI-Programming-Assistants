class Solution {
public:
    int strongPasswordChecker(string s) {
        int n = s.length();
        bool hasLower = false, hasUpper = false, hasDigit = false;
        for (char c : s) {
            if (islower(c)) hasLower = true;
            if (isupper(c)) hasUpper = true;
            if (isdigit(c)) hasDigit = true;
        }
        int missingTypes = !hasLower + !hasUpper + !hasDigit;

        if (n < 6) return max(6 - n, missingTypes);
        if (n <= 20) {
            int replaceCount = 0;
            for (int i = 2; i < n; i++) {
                if (s[i] == s[i - 1] && s[i] == s[i - 2]) {
                    replaceCount++;
                    i++;
                }
            }
            return max(replaceCount, missingTypes);
        }

        int replaceCount = 0, deleteCount = n - 20;
        vector<int> counts(3);
        for (int i = 2; i < n; i++) {
            if (s[i] == s[i - 1] && s[i] == s[i - 2]) {
                int length = 2;
                while (i < n && s[i] == s[i - 1]) {
                    length++;
                    i++;
                }
                counts[length % 3]++;
            }
        }

        for (int i = 0; i < 3 && deleteCount > 0; i++) {
            while (counts[i] > 0 && deleteCount > 0) {
                if (i > 0) {
                    int toDelete = min(counts[i], deleteCount / (i + 1));
                    counts[i] -= toDelete;
                    deleteCount -= toDelete * (i + 1);
                } else {
                    counts[i]--;
                    deleteCount--;
                }
                replaceCount++;
            }
        }

        replaceCount += counts[1] + counts[2] * 2;
        return missingTypes + max(replaceCount, deleteCount);
    }
};