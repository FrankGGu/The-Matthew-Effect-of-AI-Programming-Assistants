#include <vector>
#include <algorithm>

using namespace std;

vector<int> mostVisited(int n, vector<int>& rounds) {
    vector<int> count(n + 1, 0);
    int start = rounds[0], end = rounds.back();

    if (start <= end) {
        for (int i = start; i <= end; ++i) 
            count[i]++;
    } else {
        for (int i = start; i <= n; ++i) 
            count[i]++;
        for (int i = 1; i <= end; ++i) 
            count[i]++;
    }

    int maxVisits = *max_element(count.begin(), count.end());
    vector<int> result;

    for (int i = 1; i <= n; ++i) {
        if (count[i] == maxVisits) {
            result.push_back(i);
        }
    }

    return result;
}