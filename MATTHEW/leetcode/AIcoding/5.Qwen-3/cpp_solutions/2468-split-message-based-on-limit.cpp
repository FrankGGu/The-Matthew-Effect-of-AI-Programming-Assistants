#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> splitMessage(vector<int>& message, int limit) {
        int n = message.size();
        vector<int> result;
        for (int i = 0; i < n; ) {
            int len = 0;
            while (i < n && len + to_string(i + 1).size() + message[i] <= limit) {
                len += to_string(i + 1).size() + message[i];
                i++;
            }
            if (i == n) break;
            result.push_back(i + 1);
        }
        return result;
    }
};