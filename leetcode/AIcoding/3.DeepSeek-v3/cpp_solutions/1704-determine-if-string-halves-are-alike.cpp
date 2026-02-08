class Solution {
public:
    bool halvesAreAlike(string s) {
        unordered_set<char> vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'};
        int count1 = 0, count2 = 0;
        int n = s.size();
        for (int i = 0; i < n / 2; ++i) {
            if (vowels.count(s[i])) count1++;
        }
        for (int i = n / 2; i < n; ++i) {
            if (vowels.count(s[i])) count2++;
        }
        return count1 == count2;
    }
};