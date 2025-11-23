class Solution {
public:
    string licenseKeyFormatting(string s, int k) {
        string cleaned;
        for (char c : s) {
            if (c != '-') {
                cleaned += toupper(c);
            }
        }
        int n = cleaned.size();
        if (n == 0) return "";
        int firstGroupSize = n % k;
        if (firstGroupSize == 0) firstGroupSize = k;
        string result;
        for (int i = 0; i < firstGroupSize; ++i) {
            result += cleaned[i];
        }
        for (int i = firstGroupSize; i < n; i += k) {
            result += '-';
            for (int j = 0; j < k; ++j) {
                result += cleaned[i + j];
            }
        }
        return result;
    }
};