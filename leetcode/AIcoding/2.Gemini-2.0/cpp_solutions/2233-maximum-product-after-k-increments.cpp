#include <vector>
#include <queue>

using namespace std;

int maximumProduct(vector<int>& nums, int k) {
    priority_queue<int, vector<int>, greater<int>> pq(nums.begin(), nums.end());

    while (k > 0) {
        int top = pq.top();
        pq.pop();
        pq.push(top + 1);
        k--;
    }

    long long product = 1;
    while (!pq.empty()) {
        product = (product * pq.top()) % 1000000007;
        pq.pop();
    }

    return (int)product;
}