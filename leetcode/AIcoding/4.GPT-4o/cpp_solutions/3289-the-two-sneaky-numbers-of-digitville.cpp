#include <vector>
#include <unordered_set>
using namespace std;

vector<int> findSneakyNumbers(int n) {
    unordered_set<int> seen;
    vector<int> result;

    for (int i = 1; i <= n; ++i) {
        if (seen.find(i) == seen.end()) {
            result.push_back(i);
            seen.insert(i * 2);
            seen.insert(i * 3);
        }
    }

    return result;
}