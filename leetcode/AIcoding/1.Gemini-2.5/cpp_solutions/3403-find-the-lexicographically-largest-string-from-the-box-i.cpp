#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string findLexSmallestString(string s, int a, int b) {
        int n = s.length();
        string smallest = s;
        vector<bool> visited(n, false);

        function<void(string)> dfs = [&](string current) {
            if (visited[(stoi(current.substr(0, 1)) * 100 + stoi(current.substr(1, 1)) * 10 + stoi(current.substr(2, 1))  + stoi(current.substr(3, 1)) * 10000 + stoi(current.substr(4, 1)) * 1000 + stoi(current.substr(5, 1)) * 100000) % n]) {
                return;
            }
            visited[(stoi(current.substr(0, 1)) * 100 + stoi(current.substr(1, 1)) * 10 + stoi(current.substr(2, 1))  + stoi(current.substr(3, 1)) * 10000 + stoi(current.substr(4, 1)) * 1000 + stoi(current.substr(5, 1)) * 100000) % n] = true;

            smallest = min(smallest, current);

            string add_a = current;
            for (int i = 1; i < n; i += 2) {
                add_a[i] = ((add_a[i] - '0' + a) % 10) + '0';
            }
            dfs(add_a);

            string rotate_b = current.substr(n - b) + current.substr(0, n - b);
            dfs(rotate_b);
        };

        dfs(s);

        return smallest;
    }
};