#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDistance(vector<int>& position, int m) {
        sort(position.begin(), position.end());
        int left = 0, right = position.back() - position.front();
        int answer = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int count = 1;
            int prev = position[0];

            for (int i = 1; i < position.size(); ++i) {
                if (position[i] - prev >= mid) {
                    count++;
                    prev = position[i];
                }
            }

            if (count >= m) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return answer;
    }
};