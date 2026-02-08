#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string findLexSmallestString(string s, int a, int b) {
        int n = s.size();
        string result = s;
        vector<bool> visited(n, false);
        vector<string> queue;
        queue.push_back(s);
        visited[0] = true;

        while (!queue.empty()) {
            string curr = queue.back();
            queue.pop_back();

            if (curr < result) {
                result = curr;
            }

            // Operation 1: Add a to each digit
            string addA = curr;
            for (int i = 0; i < n; i++) {
                addA[i] = '0' + (curr[i] - '0' + a) % 10;
            }
            if (!visited[0]) {
                visited[0] = true;
                queue.push_back(addA);
            }

            // Operation 2: Rotate the string
            string rotateB = curr.substr(n - b) + curr.substr(0, n - b);
            if (!visited[(n - b) % n]) {
                visited[(n - b) % n] = true;
                queue.push_back(rotateB);
            }
        }

        return result;
    }
};