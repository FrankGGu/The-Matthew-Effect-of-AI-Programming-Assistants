#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countZeroRequests(vector<int>& servers, vector<int>& requests) {
        int n = servers.size();
        int m = requests.size();
        vector<int> count(n, 0);

        for (int i = 0; i < m; ++i) {
            int server = requests[i];
            if (server >= 0 && server < n) {
                count[server]++;
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            if (count[i] == 0) {
                result++;
            }
        }

        return result;
    }
};