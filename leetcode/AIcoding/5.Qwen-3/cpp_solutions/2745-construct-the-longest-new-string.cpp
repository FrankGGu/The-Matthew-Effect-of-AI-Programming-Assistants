#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestString(int n, int x) {
        unordered_map<char, int> count;
        count['a'] = 0;
        count['b'] = 0;
        count['c'] = 0;
        for (int i = 0; i < n; ++i) {
            if (count['a'] <= count['b'] && count['a'] <= count['c']) {
                count['a']++;
            } else if (count['b'] <= count['c']) {
                count['b']++;
            } else {
                count['c']++;
            }
        }
        return count['a'] + count['b'] + count['c'];
    }
};