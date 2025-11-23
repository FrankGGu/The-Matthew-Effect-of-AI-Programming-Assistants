#include <vector>

using namespace std;

class Solution {
public:
    int findTheWinner(int n, int k) {
        vector<int> people(n);
        for (int i = 0; i < n; ++i) {
            people[i] = i + 1;
        }

        int current = 0;
        while (people.size() > 1) {
            current = (current + k - 1) % people.size();
            people.erase(people.begin() + current);
        }

        return people[0];
    }
};