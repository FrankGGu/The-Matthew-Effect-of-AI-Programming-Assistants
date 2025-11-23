#include <vector>
#include <set>
using namespace std;

vector<int> circularGameLosers(int n, int k) {
    vector<bool> eliminated(n + 1, false);
    int current = 0;
    for (int i = 1; i <= n; i++) {
        current = (current + k) % n;
        eliminated[current == 0 ? n : current] = true;
    }
    vector<int> losers;
    for (int i = 1; i <= n; i++) {
        if (!eliminated[i]) {
            losers.push_back(i);
        }
    }
    return losers;
}