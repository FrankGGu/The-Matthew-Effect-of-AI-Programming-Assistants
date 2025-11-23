#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

long long kSum(vector<int>& nums, int k) {
    long long sum = 0;
    vector<int> absNums;
    for (int num : nums) {
        if (num >= 0) {
            sum += num;
        } else {
            num = -num;
        }
        absNums.push_back(num);
    }

    sort(absNums.begin(), absNums.end());

    priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
    pq.push({absNums[0], 0});

    for (int i = 1; i < k; ++i) {
        auto [currSum, currIndex] = pq.top();
        pq.pop();

        if (currIndex + 1 < absNums.size()) {
            pq.push({currSum - absNums[currIndex] + absNums[currIndex + 1], currIndex + 1});
            pq.push({currSum + absNums[currIndex + 1], currIndex + 1});
        }
    }

    return sum - pq.top().first;
}