#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfSubstrings(string s) {
        unordered_map<char, int> count;
        int left = 0, result = 0;
        for (int right = 0; right < s.size(); ++right) {
            count[s[right]]++;
            while (count.size() == 3) {
                result += s.size() - right;
                count[s[left]]--;
                if (count[s[left]] == 0) {
                    count.erase(s[left]);
                }
                left++;
            }
        }
        return result;
    }
};