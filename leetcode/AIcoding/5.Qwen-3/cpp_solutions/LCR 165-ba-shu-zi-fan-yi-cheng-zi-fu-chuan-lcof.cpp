#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string decrypt(string s, vector<int>& key) {
        string result;
        for (int i = 0; i < s.length(); ++i) {
            char c = s[i];
            int k = key[i % key.size()];
            char decrypted = c - k;
            result += decrypted;
        }
        return result;
    }
};