#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

long long solve() {
    int n;
    cin >> n;
    vector<int> a(n);
    vector<int> cost(n);
    for (int i = 0; i < n; ++i) {
        cin >> a[i];
    }
    for (int i = 0; i < n; ++i) {
        cin >> cost[i];
    }

    vector<int> p(n);
    for (int i = 0; i < n; ++i) {
        p[i] = i;
    }

    long long min_cost = -1;

    do {
        long long current_cost = 0;
        for (int i = 0; i < n; ++i) {
            current_cost += (long long)a[i] * cost[p[i]];
        }

        if (min_cost == -1 || current_cost < min_cost) {
            min_cost = current_cost;
        }
    } while (next_permutation(p.begin(), p.end()));

    return min_cost;
}

int main() {
    cout << solve() << endl;
    return 0;
}