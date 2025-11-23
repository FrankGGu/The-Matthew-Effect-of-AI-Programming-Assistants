#include <iostream>
#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> sortJumbled(const vector<int>& arr) {
        vector<pair<int, int>> indexedArr;
        for (int i = 0; i < arr.size(); ++i) {
            indexedArr.push_back({arr[i], i});
        }

        auto customCompare = [&](const pair<int, int>& a, const pair<int, int>& b) {
            int valA = a.first;
            int valB = b.first;
            int keyA = 0, keyB = 0;
            int digitCount = 0;

            while (valA > 0 || valB > 0) {
                int digitA = valA % 10;
                int digitB = valB % 10;
                keyA += digitA * pow(10, digitCount);
                keyB += digitB * pow(10, digitCount);
                valA /= 10;
                valB /= 10;
                digitCount++;
            }

            return keyA < keyB;
        };

        sort(indexedArr.begin(), indexedArr.end(), customCompare);

        vector<int> result;
        for (const auto& p : indexedArr) {
            result.push_back(arr[p.second]);
        }

        return result;
    }
};