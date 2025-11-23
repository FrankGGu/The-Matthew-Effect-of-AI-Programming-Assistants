#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>
#include <string>

using namespace std;

class Solution {
public:
    int minMutation(string startGene, string endGene, vector<string>& bank) {
        unordered_set<string> bankSet(bank.begin(), bank.end());
        queue<pair<string, int>> q;
        q.push({startGene, 0});
        unordered_set<string> visited;
        visited.insert(startGene);
        vector<char> chars = {'A', 'C', 'G', 'T'};

        while (!q.empty()) {
            auto [current, steps] = q.front();
            q.pop();

            if (current == endGene) {
                return steps;
            }

            for (char c : chars) {
                for (int i = 0; i < 8; ++i) {
                    string next = current;
                    next[i] = c;
                    if (bankSet.find(next) != bankSet.end() && visited.find(next) == visited.end()) {
                        visited.insert(next);
                        q.push({next, steps + 1});
                    }
                }
            }
        }

        return -1;
    }
};