#include <vector>
#include <unordered_map>
#include <random>

using namespace std;

class Solution {
public:
    Solution(int n, vector<int>& blacklist) : N(n) {
        int wlen = n - blacklist.size();
        unordered_map<int, int> m;
        for (int b : blacklist) {
            m[b] = 1;
        }

        int last = n - 1;
        for (int b : blacklist) {
            if (b < wlen) {
                while (m.count(last)) {
                    last--;
                }
                mapping[b] = last;
                last--;
            }
        }
    }

    int pick() {
        int k = rand() % N_W;
        if (mapping.count(k)) {
            return mapping[k];
        }
        return k;
    }

private:
    unordered_map<int, int> mapping;
    int N;
    int N_W;
    int last;

    Solution(const Solution&) = delete;
    Solution& operator=(const Solution&) = delete;

    Solution(Solution&&) = delete;
    Solution& operator=(Solution&&) = delete;

    int getRandomNumber(int min, int max) {
        random_device rd;
        mt19937 gen(rd());
        uniform_int_distribution<> distrib(min, max);
        return distrib(gen);
    }
};