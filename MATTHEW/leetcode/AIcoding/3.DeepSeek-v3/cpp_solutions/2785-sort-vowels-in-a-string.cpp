class Solution {
public:
    string sortVowels(string s) {
        vector<char> vowels;
        for (char c : s) {
            if (tolower(c) == 'a' || tolower(c) == 'e' || tolower(c) == 'i' || tolower(c) == 'o' || tolower(c) == 'u') {
                vowels.push_back(c);
            }
        }
        sort(vowels.begin(), vowels.end());
        int idx = 0;
        for (char &c : s) {
            if (tolower(c) == 'a' || tolower(c) == 'e' || tolower(c) == 'i' || tolower(c) == 'o' || tolower(c) == 'u') {
                c = vowels[idx++];
            }
        }
        return s;
    }
};