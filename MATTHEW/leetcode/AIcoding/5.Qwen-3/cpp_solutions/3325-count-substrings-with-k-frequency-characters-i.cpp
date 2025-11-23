#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int kCount(string s, int k) {
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            unordered_map<char, int> freq;
            for (int j = i; j < s.length(); j++) {
                freq[s[j]]++;
                if (freq[s[j]] == k) {
                    count++;
                }
            }
        }
        return count;
    }
};