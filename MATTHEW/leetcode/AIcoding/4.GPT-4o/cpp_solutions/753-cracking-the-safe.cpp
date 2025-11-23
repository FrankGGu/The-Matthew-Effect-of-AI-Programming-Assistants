#include <string>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    string crackSafe(int n, int k) {
        string result;
        // Start with '0's
        for (int i = 0; i < n; ++i) {
            result += '0';
        }

        unordered_set<string> visited;
        visited.insert(result);

        dfs(result, visited, n, k);

        return result;
    }

private:
    void dfs(string& result, unordered_set<string>& visited, int n, int k) {
        for (int i = 0; i < k; ++i) {
            string next = result.substr(result.size() - n + 1) + to_string(i);
            if (visited.find(next) == visited.end()) {
                visited.insert(next);
                result += to_string(i);
                dfs(result, visited, n, k);
                // Backtrack
                result.pop_back();
                visited.erase(next);
            }
        }
    }
};