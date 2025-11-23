#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long wonderfulSubstrings(vector<char>& word) {
        unordered_map<long long, int> count;
        count[0] = 1;
        long long result = 0;
        long long mask = 0;

        for (char c : word) {
            mask ^= (1LL << (c - 'a'));
            for (int i = 0; i < 26; ++i) {
                result += count[mask ^ (1LL << i)];
            }
            result += count[mask];
            count[mask]++;
        }

        return result;
    }
};