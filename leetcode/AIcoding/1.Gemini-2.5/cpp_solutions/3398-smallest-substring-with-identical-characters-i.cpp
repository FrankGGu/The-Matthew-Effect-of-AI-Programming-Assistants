class Solution {
public:
    int smallestSubstringWithIdenticalCharactersI(std::string s) {
        // Iterate through the string to check for any adjacent identical characters.
        // A substring of length 2 (e.g., "aa", "bb") is the smallest possible
        // substring consisting of identical characters (assuming length must be at least 2).
        // If such a substring exists, its length is 2, which is the minimum.
        for (int i = 0; i < s.length() - 1; ++i) {
            if (s[i] == s[i+1]) {
                // Found two adjacent identical characters, so the smallest length is 2.
                return 2;
            }
        }

        // If the loop completes, it means no two adjacent characters were identical.
        // This implies that no substring of length 2 or greater with identical characters exists.
        // In such a case, return -1 to indicate that no such substring was found.
        return -1;
    }
};