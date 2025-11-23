#include <string>
#include <vector>
#include <queue>
#include <unordered_set>
#include <utility>

class Solution {
public:
    int minMutation(std::string start, std::string end, std::vector<std::string>& bank) {
        std::unordered_set<std::string> bank_set(bank.begin(), bank.end());

        if (bank_set.find(end) == bank_set.end() && start != end) {
            return -1;
        }

        std::queue<std::pair<std::string, int>> q;
        q.push({start, 0});

        std::unordered_set<std::string> visited;
        visited.insert(start);

        char gene_chars[] = {'A', 'C', 'G', 'T'};

        while (!q.empty()) {
            std::pair<std::string, int> current = q.front();
            q.pop();

            std::string current_gene = current.first;
            int mutations = current.second;

            if (current_gene == end) {
                return mutations;
            }

            for (int i = 0; i < current_gene.length(); ++i) {
                char original_char = current_gene[i];
                for (char c : gene_chars) {
                    if (c == original_char) {
                        continue;
                    }
                    current_gene[i] = c;

                    if (bank_set.count(current_gene) && visited.find(current_gene) == visited.end()) {
                        visited.insert(current_gene);
                        q.push({current_gene, mutations + 1});
                    }
                }
                current_gene[i] = original_char;
            }
        }

        return -1;
    }
};