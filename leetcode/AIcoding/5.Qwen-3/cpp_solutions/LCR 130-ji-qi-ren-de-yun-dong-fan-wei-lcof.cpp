#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int hangTheClothes(vector<int>& clothes, int k) {
        sort(clothes.begin(), clothes.end());
        int n = clothes.size();
        int result = 0;
        for (int i = 0; i < n; i += k) {
            result += clothes[i];
        }
        return result;
    }
};