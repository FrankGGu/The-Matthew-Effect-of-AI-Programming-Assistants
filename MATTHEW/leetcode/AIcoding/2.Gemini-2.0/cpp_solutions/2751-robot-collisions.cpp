#include <vector>
#include <stack>

using namespace std;

vector<int> robotCollisions(vector<int>& positions, string directions, vector<int>& healths) {
    int n = positions.size();
    vector<int> indices(n);
    for (int i = 0; i < n; ++i) {
        indices[i] = i;
    }
    sort(indices.begin(), indices.end(), [&](int i, int j) {
        return positions[i] < positions[j];
    });

    stack<int> s;
    vector<bool> alive(n, true);

    for (int i : indices) {
        if (directions[i] == 'R') {
            s.push(i);
        } else {
            while (!s.empty()) {
                int j = s.top();
                if (healths[i] > healths[j]) {
                    healths[i]--;
                    healths[j]--;
                    alive[j] = false;
                    s.pop();
                } else if (healths[i] < healths[j]) {
                    healths[i]--;
                    healths[j]--;
                    alive[i] = false;
                    break;
                } else {
                    healths[i]--;
                    healths[j]--;
                    alive[i] = false;
                    alive[j] = false;
                    s.pop();
                    break;
                }
            }
            if (alive[i] && healths[i] > 0) {
                s.push(i);
            }
        }
    }

    vector<int> result;
    for (int i = 0; i < n; ++i) {
        if (alive[i]) {
            result.push_back(healths[i]);
        }
    }

    return result;
}