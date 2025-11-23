#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string shiftingLetters(string s, vector<vector<int>>& shifts) {
        int n = s.size();
        vector<long long> delta(n + 1, 0);

        for (const auto& shift : shifts) {
            int start = shift[0];
            int end = shift[1];
            int amount = shift[2];
            delta[start] += amount;
            if (end + 1 < n) {
                delta[end + 1] -= amount;
            }
        }

        long long current = 0;
        for (int i = 0; i < n; ++i) {
            current += delta[i];
            s[i] = 'a' + (s[i] - 'a' + current) % 26;
        }

        return s;
    }
};