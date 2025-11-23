#include <string>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class TrieNode {
public:
    TrieNode* children[26];
    int count;

    TrieNode() {
        for (int i = 0; i < 26; ++i) {
            children[i] = nullptr;
        }
        count = 0;
    }
};

class Solution {
public:
    long long countPrefixSuffixPairs(vector<string>& words) {
        int n = words.size();
        long long ans = 0;
        TrieNode* root = new TrieNode();

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (words[j].size() < words[i].size()) continue;
                if (words[i].size() > words[j].size()) continue;

                bool prefix = true;
                for (int k = 0; k < words[i].size(); ++k) {
                    if (words[i][k] != words[j][k]) {
                        prefix = false;
                        break;
                    }
                }

                bool suffix = true;
                for (int k = 0; k < words[i].size(); ++k) {
                    if (words[i][k] != words[j][words[j].size() - words[i].size() + k]) {
                        suffix = false;
                        break;
                    }
                }

                if (prefix && suffix) {
                    ans++;
                }
            }
        }

        return ans;
    }
};