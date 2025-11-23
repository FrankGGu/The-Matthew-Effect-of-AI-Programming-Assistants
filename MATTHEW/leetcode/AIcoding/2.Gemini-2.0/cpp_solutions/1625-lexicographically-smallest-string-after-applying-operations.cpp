#include <string>
#include <queue>
#include <set>

using namespace std;

class Solution {
public:
    string findLexSmallestString(string s, int a, int b) {
        int n = s.length();
        string smallest = s;
        queue<string> q;
        q.push(s);
        set<string> visited;
        visited.insert(s);

        while (!q.empty()) {
            string curr = q.front();
            q.pop();

            if (curr < smallest) {
                smallest = curr;
            }

            string add_a = curr;
            for (int i = 1; i < n; i += 2) {
                add_a[i] = ((add_a[i] - '0' + a) % 10) + '0';
            }

            if (visited.find(add_a) == visited.end()) {
                q.push(add_a);
                visited.insert(add_a);
            }

            string rotate_b = curr.substr(n - b) + curr.substr(0, n - b);
            if (visited.find(rotate_b) == visited.end()) {
                q.push(rotate_b);
                visited.insert(rotate_b);
            }
        }

        return smallest;
    }
};