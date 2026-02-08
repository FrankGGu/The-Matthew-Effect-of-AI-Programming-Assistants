#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumProduct(vector<int>& nums, int k) {
        priority_queue<int, vector<int>, greater<int>> pq;
        for (int num : nums) {
            pq.push(num);
        }

        while (k > 0) {
            int smallest = pq.top();
            pq.pop();
            pq.push(smallest + 1);
            k--;
        }

        long long product = 1;
        const int mod = 1e9 + 7;
        while (!pq.empty()) {
            product = (product * pq.top()) % mod;
            pq.pop();
        }

        return product;
    }
};