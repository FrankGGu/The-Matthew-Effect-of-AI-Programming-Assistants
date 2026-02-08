#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string customSortString(string S, string T) {
        unordered_map<char, int> count;
        for (char c : T) {
            count[c]++;
        }

        string result;

        for (char c : S) {
            while (count[c] > 0) {
                result += c;
                count[c]--;
            }
        }

        for (char c : T) {
            if (count[c] > 0) {
                result += c;
                count[c]--;
            }
        }

        return result;
    }
};