#include <string>
#include <algorithm>
#include <queue>
#include <unordered_set>

using namespace std;

string lexicographicallySmallestString(string s, int a, int b) {
    int n = s.length();
    string smallest = s;
    unordered_set<string> visited;
    queue<string> q;
    q.push(s);
    visited.insert(s);

    while (!q.empty()) {
        string curr = q.front();
        q.pop();

        smallest = min(smallest, curr);

        string add_a = curr;
        for (int i = 1; i < n; i += 2) {
            add_a[i] = (add_a[i] - '0' + a) % 10 + '0';
        }

        if (visited.find(add_a) == visited.end()) {
            q.push(add_a);
            visited.insert(add_a);
        }

        string rotate_b = curr;
        rotate(rotate_b.begin(), rotate_b.begin() + b, rotate_b.end());

        if (visited.find(rotate_b) == visited.end()) {
            q.push(rotate_b);
            visited.insert(rotate_b);
        }
    }

    return smallest;
}