#include <iostream>
#include <vector>
#include <unordered_map>
#include <string>

using namespace std;

class Solution {
private:
    unordered_map<char, char> parent;

    char find(char x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unite(char x, char y) {
        char rootX = find(x);
        char rootY = find(y);
        if (rootX != rootY) {
            parent[rootX] = rootY;
        }
    }

public:
    bool equations(vector<string>& equations) {
        for (char c = 'a'; c <= 'z'; ++c) {
            parent[c] = c;
        }

        for (const string& eq : equations) {
            if (eq[1] == '=') {
                unite(eq[0], eq[3]);
            }
        }

        for (const string& eq : equations) {
            if (eq[1] == '!') {
                char rootA = find(eq[0]);
                char rootB = find(eq[3]);
                if (rootA == rootB) {
                    return false;
                }
            }
        }

        return true;
    }
};