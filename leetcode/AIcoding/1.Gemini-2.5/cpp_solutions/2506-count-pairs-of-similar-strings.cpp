#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <set>

using namespace std;

class Solution {
public:
    int similarPairs(vector<string>& words) {
        int count = 0;
        for (int i = 0; i < words.size(); ++i) {
            for (int j = i + 1; j < words.size(); ++j) {
                set<char> set1, set2;
                for (char c : words[i]) {
                    set1.insert(c);
                }
                for (char c : words[j]) {
                    set2.insert(c);
                }
                if (set1 == set2) {
                    count++;
                }
            }
        }
        return count;
    }
};