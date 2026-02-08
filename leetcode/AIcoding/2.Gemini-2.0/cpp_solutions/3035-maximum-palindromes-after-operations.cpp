#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxPalindromesAfterOperations(vector<string>& words) {
        vector<int> lengths;
        for (const string& word : words) {
            lengths.push_back(word.length());
        }
        sort(lengths.begin(), lengths.end());

        int total_chars = 0;
        vector<int> counts(26, 0);
        for (const string& word : words) {
            for (char c : word) {
                counts[c - 'a']++;
                total_chars++;
            }
        }

        int pairs = 0;
        for (int count : counts) {
            pairs += count / 2;
        }

        int palindromes = 0;
        for (int len : lengths) {
            if (pairs >= len / 2) {
                pairs -= len / 2;
                palindromes++;
            } else {
                break;
            }
        }

        return palindromes;
    }
};