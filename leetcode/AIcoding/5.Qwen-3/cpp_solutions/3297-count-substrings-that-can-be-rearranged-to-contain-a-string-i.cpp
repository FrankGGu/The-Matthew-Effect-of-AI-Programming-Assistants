#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countAnagrams(string s) {
        int n = s.length();
        int result = 0;
        for (int i = 0; i < n; ++i) {
            unordered_map<char, int> freq;
            for (int j = i; j < n; ++j) {
                freq[s[j]]++;
                bool valid = true;
                for (auto& [ch, count] : freq) {
                    if (count > 1) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    result++;
                }
            }
        }
        return result;
    }
};