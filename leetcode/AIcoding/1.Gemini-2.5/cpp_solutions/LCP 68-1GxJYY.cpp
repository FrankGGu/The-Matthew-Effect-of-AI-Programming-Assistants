#include <vector>
#include <deque>
#include <algorithm>

class Solution {
public:
    long long beautifulBouquets(std::vector<int>& flowers, int k) {
        int n = flowers.size();
        if (n == 0) {
            return 0;
        }

        long long count = 0;
        int left = 0;
        std::deque<int> max_dq; 
        std::deque<int> min_dq; 

        for (int right = 0; right < n; ++right) {
            while (!max_dq.empty() && flowers[max_dq.back()] <= flowers[right]) {
                max_dq.pop_back();
            }
            max_dq.push_back(right);

            while (!min_dq.empty() && flowers[min_dq.back()] >= flowers[right]) {
                min_dq.pop_back();
            }
            min_dq.push_back(right);

            while (flowers[max_dq.front()] - flowers[min_dq.front()] > k) {
                left++;
                if (!max_dq.empty() && max_dq.front() < left) {
                    max_dq.pop_front();
                }
                if (!min_dq.empty() && min_dq.front() < left) {
                    min_dq.pop_front();
                }
            }

            count += (right - left + 1);
        }

        return count;
    }
};