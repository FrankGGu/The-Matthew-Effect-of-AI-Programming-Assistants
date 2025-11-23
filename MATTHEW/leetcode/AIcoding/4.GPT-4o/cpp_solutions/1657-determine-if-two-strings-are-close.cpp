class Solution {
public:
    bool closeStrings(string word1, string word2) {
        if (word1.size() != word2.size()) return false;

        vector<int> count1(26, 0), count2(26, 0);
        unordered_set<char> set1(word1.begin(), word1.end()), set2(word2.begin(), word2.end());

        for (char c : word1) count1[c - 'a']++;
        for (char c : word2) count2[c - 'a']++;

        return set1 == set2 && 
               vector<int>(count1.begin(), count1.end()) == vector<int>(count2.begin(), count2.end());
    }
};