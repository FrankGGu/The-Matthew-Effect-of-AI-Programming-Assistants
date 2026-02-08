#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maximumRemovals(vector<int>& source, vector<int>& target) {
        unordered_map<char, int> count;
        for (char c : target) {
            count[c]++;
        }

        int res = 0;
        int i = 0;
        while (i < source.size()) {
            if (count.find(source[i]) != count.end() && count[source[i]] > 0) {
                count[source[i]]--;
                res++;
            }
            i++;
        }
        return res;
    }
};