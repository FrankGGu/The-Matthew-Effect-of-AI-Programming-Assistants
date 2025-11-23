#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

vector<int> advantageCount(vector<int>& A, vector<int>& B) {
    sort(A.begin(), A.end());
    int n = B.size();
    vector<int> result(n);
    priority_queue<pair<int, int>> pq;

    for (int i = 0; i < n; ++i) {
        pq.push({B[i], i});
    }

    int j = 0;
    while (!pq.empty()) {
        auto [b_val, index] = pq.top();
        pq.pop();

        while (j < n && A[j] <= b_val) {
            j++;
        }

        if (j < n) {
            result[index] = A[j++];
        } else {
            result[index] = A[0];
        }
    }

    return result;
}