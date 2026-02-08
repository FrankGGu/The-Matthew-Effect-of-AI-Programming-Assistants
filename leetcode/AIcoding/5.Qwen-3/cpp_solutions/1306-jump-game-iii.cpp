#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool canReach(vector<int>& arr, int start) {
        unordered_set<int> visited;
        return dfs(arr, start, visited);
    }

    bool dfs(vector<int>& arr, int index, unordered_set<int>& visited) {
        if (index < 0 || index >= arr.size() || visited.count(index)) {
            return false;
        }
        if (arr[index] == 0) {
            return true;
        }
        visited.insert(index);
        return dfs(arr, index + arr[index], visited) || dfs(arr, index - arr[index], visited);
    }
};