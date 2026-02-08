#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> vowelStrings(vector<string>& words, vector<vector<int>>& queries) {
        vector<int> prefix;
        int count = 0;
        for (const string& word : words) {
            if ((word[0] == 'a' || word[0] == 'e' || word[0] == 'i' || word[0] == 'o' || word[0] == 'u') &&
                (word.back() == 'a' || word.back() == 'e' || word.back() == 'i' || word.back() == 'o' || word.back() == 'u')) {
                count++;
            }
            prefix.push_back(count);
        }

        vector<int> result;
        for (const vector<int>& q : queries) {
            int left = q[0];
            int right = q[1];
            if (left == 0) {
                result.push_back(prefix[right]);
            } else {
                result.push_back(prefix[right] - prefix[left - 1]);
            }
        }
        return result;
    }
};