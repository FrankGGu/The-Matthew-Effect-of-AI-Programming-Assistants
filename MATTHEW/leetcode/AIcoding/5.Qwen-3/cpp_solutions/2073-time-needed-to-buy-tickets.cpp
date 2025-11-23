#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int timeRequiredToBuy(vector<int>& tickets, int k) {
        int time = 0;
        for (int i = 0; i < tickets.size(); ++i) {
            if (i < k) {
                time += min(tickets[i], tickets[k]);
            } else if (i > k) {
                time += min(tickets[i], tickets[k] - 1);
            } else {
                time += tickets[k];
            }
        }
        return time;
    }
};