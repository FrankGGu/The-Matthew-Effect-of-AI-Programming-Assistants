#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int electricCarTour(vector<int>& stations, int k) {
        int n = stations.size();
        vector<int> dist(n, 0);
        for (int i = 1; i < n; ++i) {
            dist[i] = dist[i - 1] + stations[i - 1];
        }

        priority_queue<int> pq;
        int result = 0;
        int current = 0;
        int index = 0;

        while (current < n - 1) {
            while (index < n && dist[index] - dist[current] <= k) {
                pq.push(stations[index]);
                index++;
            }

            if (pq.empty()) {
                return -1;
            }

            result++;
            current = index - 1;
            int maxStation = pq.top();
            pq.pop();
            current = index - 1;
            while (index < n && dist[index] - dist[current] <= k) {
                pq.push(stations[index]);
                index++;
            }
        }

        return result;
    }
};