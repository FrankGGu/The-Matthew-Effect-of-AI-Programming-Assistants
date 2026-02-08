#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minNumberOfFrogsCroaking(string croak) {
        unordered_map<char, int> count;
        vector<int> indices(6);
        string pattern = "croak";
        for (int i = 0; i < 5; ++i) {
            indices[i + 1] = i;
        }
        int frogs = 0;
        int max_frogs = 0;
        for (char c : croak) {
            int idx = indices[c];
            if (idx == 0) {
                if (count['c'] > 0) {
                    count['c']--;
                    count['r']++;
                } else {
                    frogs++;
                    max_frogs = max(max_frogs, frogs);
                    count['r']++;
                }
            } else {
                if (count[pattern[idx - 1]] > 0) {
                    count[pattern[idx - 1]]--;
                    count[pattern[idx]]++;
                } else {
                    return -1;
                }
            }
        }
        return (count['k'] == 0) ? max_frogs : -1;
    }
};