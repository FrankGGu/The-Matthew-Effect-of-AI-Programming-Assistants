#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::string findLexSmallestString(std::string s, int a, int b) {
        std::string result = s;
        std::vector<bool> visited(1000, false);
        std::queue<std::string> q;
        q.push(s);
        visited[std::stoi(s)] = true;

        while (!q.empty()) {
            std::string current = q.front();
            q.pop();
            if (current < result) {
                result = current;
            }
            // Add `a`
            std::string addA = current;
            for (int i = 0; i < addA.size(); ++i) {
                addA[i] = (addA[i] - '0' + a) % 10 + '0';
            }
            if (!visited[std::stoi(addA)]) {
                visited[std::stoi(addA)] = true;
                q.push(addA);
            }
            // Rotate by `b`
            std::string rotateB = current;
            std::rotate(rotateB.begin(), rotateB.begin() + rotateB.size() - b, rotateB.end());
            if (!visited[std::stoi(rotateB)]) {
                visited[std::stoi(rotateB)] = true;
                q.push(rotateB);
            }
        }
        return result;
    }
};