#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string password(string s, vector<int> &k) {
        int n = s.length();
        for (int i = 0; i < k.size(); ++i) {
            int a = k[i] % n;
            char c = s[a];
            s.erase(a, 1);
            s.insert(0, 1, c);
        }
        return s;
    }
};