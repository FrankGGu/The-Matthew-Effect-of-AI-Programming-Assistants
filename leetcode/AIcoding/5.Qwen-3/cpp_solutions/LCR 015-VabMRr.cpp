#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> findAnagrams(string s, string p) {
        vector<int> result;
        if (s.length() < p.length()) return result;

        unordered_map<char, int> pCount;
        for (char c : p) {
            pCount[c]++;
        }

        int left = 0, right = 0, count = p.length();

        while (right < s.length()) {
            char c = s[right];
            if (pCount.find(c) != pCount.end()) {
                if (pCount[c] > 0) {
                    count--;
                }
                pCount[c]--;
            }
            right++;

            if (right - left == p.length()) {
                if (count == 0) {
                    result.push_back(left);
                }

                char leftChar = s[left];
                if (pCount.find(leftChar) != pCount.end()) {
                    pCount[leftChar]++;
                    if (pCount[leftChar] > 0) {
                        count++;
                    }
                }
                left++;
            }
        }

        return result;
    }
};