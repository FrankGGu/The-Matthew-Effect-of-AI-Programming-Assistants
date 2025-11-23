#include <iostream>
#include <vector>
#include <unordered_map>
#include <cmath>

using namespace std;

class Solution {
private:
    vector<int> parent;

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSet(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootY] = rootX;
        }
    }

    int getPrimeFactor(int n) {
        for (int i = 2; i <= sqrt(n); ++i) {
            if (n % i == 0) {
                return i;
            }
        }
        return n;
    }

public:
    int largestComponentSize(vector<int>& nums) {
        int maxNum = *max_element(nums.begin(), nums.end());
        parent.resize(maxNum + 1);
        for (int i = 0; i <= maxNum; ++i) {
            parent[i] = i;
        }

        for (int num : nums) {
            int factor = getPrimeFactor(num);
            if (factor != num) {
                unionSet(num, factor);
            }
        }

        unordered_map<int, int> componentCount;
        int maxSize = 0;
        for (int num : nums) {
            int root = find(num);
            componentCount[root]++;
            maxSize = max(maxSize, componentCount[root]);
        }

        return maxSize;
    }
};