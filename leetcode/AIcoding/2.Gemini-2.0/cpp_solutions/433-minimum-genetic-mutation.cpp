#include <string>
#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minMutation(string startGene, string endGene, vector<string>& bank) {
        unordered_set<string> validGenes(bank.begin(), bank.end());
        if (validGenes.find(endGene) == validGenes.end()) {
            return -1;
        }

        queue<pair<string, int>> q;
        q.push({startGene, 0});
        unordered_set<string> visited;
        visited.insert(startGene);

        while (!q.empty()) {
            string currentGene = q.front().first;
            int mutations = q.front().second;
            q.pop();

            if (currentGene == endGene) {
                return mutations;
            }

            for (int i = 0; i < currentGene.length(); ++i) {
                char originalChar = currentGene[i];
                for (char c : {'A', 'C', 'G', 'T'}) {
                    currentGene[i] = c;
                    if (validGenes.find(currentGene) != validGenes.end() && visited.find(currentGene) == visited.end()) {
                        q.push({currentGene, mutations + 1});
                        visited.insert(currentGene);
                    }
                }
                currentGene[i] = originalChar;
            }
        }

        return -1;
    }
};