#include <vector>

using namespace std;

class Solution {
public:
    int longestUploadedPrefix(vector<int>& uploaded, int n) {
        vector<bool> uploaded_status(n + 1, false);
        int count = 0;
        for (int i = 0; i < uploaded.size(); ++i) {
            uploaded_status[uploaded[i]] = true;
            if (uploaded[i] == count + 1) {
                while (count + 1 <= n && uploaded_status[count + 1]) {
                    count++;
                }
            }
        }
        return count;
    }
};