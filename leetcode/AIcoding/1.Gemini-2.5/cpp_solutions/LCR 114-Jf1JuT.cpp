#include <string>
#include <vector>
#include <map>
#include <set>
#include <queue>
#include <algorithm>

class Solution {
public:
    std::string alienOrder(std::vector<std::string>& words) {
        std::map<char, std::set<char>> adj;
        std::map<char, int> inDegree;
        std::set<char> allChars;

        for (const std::string& word : words) {
            for (char c : word) {
                allChars.insert(c);
                inDegree[c] = 0;
            }
        }

        for (int i = 0; i < words.size() - 1; ++i) {
            const std::string& word1 = words[i];
            const std::string& word2 = words[i+1];
            int len1 = word1.length();
            int len2 = word2.length();

            bool foundDiff = false;
            int minLen = std::min(len1, len2);

            for (int j = 0; j < minLen; ++j) {
                char c1 = word1[j];
                char c2 = word2[j];
                if (c1 != c2) {
                    if (adj[c1].find(c2) == adj[c1].end()) {
                        adj[c1].