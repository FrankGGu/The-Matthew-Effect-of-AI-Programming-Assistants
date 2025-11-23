#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long countCompleteDayPairs(vector<int>& time, int duration) {
        unordered_map<int, int> freq;
        long long count = 0;
        for (int t : time) {
            int rem = t % duration;
            count += freq[duration - rem];
            freq[rem]++;
        }
        return count;
    }
};