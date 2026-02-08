class Solution {
public:
    int maxVowels(string s, int k) {
        int maxCount = 0, currentCount = 0;
        unordered_set<char> vowels = {'a', 'e', 'i', 'o', 'u'};

        for (int i = 0; i < s.size(); i++) {
            if (vowels.count(s[i])) currentCount++;
            if (i >= k) {
                if (vowels.count(s[i - k])) currentCount--;
            }
            if (i >= k - 1) maxCount = max(maxCount, currentCount);
        }

        return maxCount;
    }
};