class Solution {
public:
    bool wordPattern(string pattern, string s) {
        istringstream iss(s);
        unordered_map<char, string> pMap;
        unordered_map<string, char> sMap;
        string word;
        int i = 0;

        while (iss >> word) {
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