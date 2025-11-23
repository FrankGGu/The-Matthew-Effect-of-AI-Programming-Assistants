#include <iostream>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    long long maximumTotalBeauty(int n, vector<int>& flowers, int newFlowers, int target, int flowerCost) {
        sort(flowers.begin(), flowers.end());
        map<int, int> freq;
        for (int f : flowers) {
            freq[f]++;
        }
        vector<int> uniqueFlowers;
        for (auto& [f, _] : freq) {
            uniqueFlowers.push_back(f);
        }
        int m = uniqueFlowers.size();
        vector<long long> prefix(m + 1, 0);
        for (int i = 0; i < m; ++i) {
            prefix[i + 1] = prefix[i] + static_cast<long long>(uniqueFlowers[i]) * freq[uniqueFlowers[i]];
        }

        long long result = 0;
        for (int i = 0; i < m; ++i) {
            int current = uniqueFlowers[i];
            int count = freq[current];
            long long total = 0;
            if (current < target) {
                long long needed = static_cast<long long>(target - current) * count;
                if (newFlowers >= needed) {
                    total += static_cast<long long>(target) * count;
                    newFlowers -= needed;
                } else {
                    long long add = newFlowers / count;
                    total += static_cast<long long>(current + add) * count;
                    newFlowers -= add * count;
                }
            } else {
                total += static_cast<long long>(current) * count;
            }
            result = max(result, total);
        }

        int left = 0;
        int right = m - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            int current = uniqueFlowers[mid];
            int count = freq[current];
            long long total = 0;
            if (current < target) {
                long long needed = static_cast<long long>(target - current) * count;
                if (newFlowers >= needed) {
                    total += static_cast<long long>(target) * count;
                    newFlowers -= needed;
                } else {
                    long long add = newFlowers / count;
                    total += static_cast<long long>(current + add) * count;
                    newFlowers -= add * count;
                }
            } else {
                total += static_cast<long long>(current) * count;
            }
            result = max(result, total);

            if (mid < m - 1 && uniqueFlowers[mid + 1] - uniqueFlowers[mid] > 1) {
                int gap = uniqueFlowers[mid + 1] - uniqueFlowers[mid] - 1;
                long long cost = static_cast<long long>(gap) * (uniqueFlowers[mid] + 1) * (gap + 1) / 2;
                if (newFlowers >= cost) {
                    newFlowers -= cost;
                    result = max(result, static_cast<long long>(uniqueFlowers[mid] + 1) * (gap + 1));
                }
            }
            left++;
            right--;
        }

        return result;
    }
};