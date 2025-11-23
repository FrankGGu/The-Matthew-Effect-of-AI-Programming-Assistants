class Solution {
public:
    bool wordPattern(string pattern, string s) {
        unordered_map<char, string> pMap;
        unordered_map<string, char> sMap;
        istringstream ss(s);
        string word;
        int i = 0;

        while (ss >> word) {
            if (i == pattern.size()) return false;
            char pChar = pattern[i];
            if (pMap.count(pChar) && pMap[pChar] != word) return false;
            if (sMap.count(word) && sMap[word] != pChar) return false;
            pMap[pChar] = word;
            sMap[word] = pChar;
            i++;
        }
        return i == pattern.size();
    }
};