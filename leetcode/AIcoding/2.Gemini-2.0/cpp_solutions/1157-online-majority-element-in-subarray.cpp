#include <vector>
#include <unordered_map>
#include <random>

using namespace std;

class MajorityChecker {
private:
    vector<int> arr;
    unordered_map<int, vector<int>> pos;
    mt19937 gen;

public:
    MajorityChecker(vector<int>& arr) : arr(arr), gen(random_device{}()) {
        for (int i = 0; i < arr.size(); ++i) {
            pos[arr[i]].push_back(i);
        }
    }

    int query(int left, int right, int threshold) {
        for (int i = 0; i < 20; ++i) {
            int idx = left + gen() % (right - left + 1);
            int candidate = arr[idx];
            int count = upper_bound(pos[candidate].begin(), pos[candidate].end(), right) -
                        lower_bound(pos[candidate].begin(), pos[candidate].end(), left);
            if (count >= threshold) {
                return candidate;
            }
        }
        return -1;
    }
};