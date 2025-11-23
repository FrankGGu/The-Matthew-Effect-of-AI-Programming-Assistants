#include <string>
#include <vector>

class Solution {
public:
    std::string pushDominoes(std::string dominoes) {
        int n = dominoes.length();
        std::vector<int> forces(n, 0);

        int force = 0;
        for (int i = 0; i < n; ++i) {
            if (dominoes[i] == 'R') {
                force = n;
            } else if (dominoes[i] == 'L') {
                force = 0;
            } else {
                if (force > 0) {
                    force--;
                }
            }
            forces[i] += force;
        }

        force = 0;
        for (int i = n - 1; i >= 0; --i) {
            if (dominoes[i] == 'L') {
                force = n;
            } else if (dominoes[i] == 'R') {
                force = 0;
            } else {
                if (force > 0) {
                    force--;
                }
            }
            forces[i] -= force;
        }

        std::string result = "";
        for (int i = 0; i < n; ++i) {
            if (forces[i] > 0) {
                result += 'R';
            } else if (forces[i] < 0) {
                result += 'L';
            } else {
                result += '.';
            }
        }

        return result;
    }
};