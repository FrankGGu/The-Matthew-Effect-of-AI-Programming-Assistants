#include <vector>
#include <string>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minMutation(string start, string end, vector<string>& bank) {
        unordered_set<string> geneBank(bank.begin(), bank.end());
        if (geneBank.find(end) == geneBank.end()) return -1;

        queue<string> q;
        q.push(start);
        int mutations = 0;

        string genes = "ACGT";

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                string current = q.front();
                q.pop();

                if (current == end) return mutations;

                for (int j = 0; j < 8; ++j) {
                    char original = current[j];
                    for (char g : genes) {
                        if (g != original) {
                            current[j] = g;
                            if (geneBank.find(current) != geneBank.end()) {
                                geneBank.erase(current);
                                q.push(current);
                            }
                        }
                    }
                    current[j] = original; // revert back
                }
            }
            mutations++;
        }
        return -1;
    }
};