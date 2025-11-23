#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countOfSubstrings(string s, int k) {
        int n = s.size();
        int result = 0;
        unordered_map<char, int> vowelCount;
        int vowels = 0;
        int consonants = 0;
        int left = 0;

        for (int right = 0; right < n; ++right) {
            if (s[right] == 'a' || s[right] == 'e' || s[right] == 'i' || s[right] == 'o' || s[right] == 'u') {
                vowelCount[s[right]]++;
                if (vowelCount[s[right]] == 1) {
                    vowels++;
                }
            } else {
                consonants++;
            }

            while (vowels == 5 && consonants >= k) {
                result++;
                if (s[left] == 'a' || s[left] == 'e' || s[left] == 'i' || s[left] == 'o' || s[left] == 'u') {
                    vowelCount[s[left]]--;
                    if (vowelCount[s[left]] == 0) {
                        vowels--;
                    }
                } else {
                    consonants--;
                }
                left++;
            }
        }

        return result;
    }
};