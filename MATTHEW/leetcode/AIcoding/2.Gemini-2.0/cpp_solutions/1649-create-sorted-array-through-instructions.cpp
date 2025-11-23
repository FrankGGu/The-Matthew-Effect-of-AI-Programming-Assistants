#include <vector>

using namespace std;

class Solution {
public:
    int createSortedArray(vector<int>& instructions) {
        int n = instructions.size();
        vector<int> sorted_arr;
        long long cost = 0;
        int mod = 1e9 + 7;

        for (int i = 0; i < n; ++i) {
            int num = instructions[i];
            int smaller = 0;
            int larger = 0;

            for (int j = 0; j < sorted_arr.size(); ++j) {
                if (sorted_arr[j] < num) {
                    smaller++;
                } else if (sorted_arr[j] > num) {
                    larger = sorted_arr.size() - j;
                    break;
                }
            }

            cost = (cost + min(smaller, (int)sorted_arr.size() - smaller)) % mod;

            int insert_pos = 0;
            while (insert_pos < sorted_arr.size() && sorted_arr[insert_pos] <= num) {
                insert_pos++;
            }
            sorted_arr.insert(sorted_arr.begin() + insert_pos, num);
        }

        return cost;
    }
};