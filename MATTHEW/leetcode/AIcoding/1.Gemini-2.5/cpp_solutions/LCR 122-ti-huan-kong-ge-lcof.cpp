#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    int pathEncryption(std::vector<int>& parent, std::string path) {
        int n = parent.size() + 1;
        std::vector<std::vector<int>> children(n);
        for (int i = 0; i < parent.size(); ++i) {
            children[parent[i]].push_back(i + 1);
        }

        int currentNode = 0;
        for (char move : path) {
            if (move == 'U') {
                if (currentNode != 0) {
                    currentNode = parent[currentNode - 1];
                }
            } else if (move == 'L') {
                if (!children[currentNode].empty()) {
                    currentNode = children[currentNode][0];
                }
            } else { // 'R'
                if (children[currentNode].size() > 1) {
                    currentNode = children[currentNode][1];
                }
            }
        }
        return currentNode;
    }
};