#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestTimeFromDigits(vector<int>& arr) {
        sort(arr.begin(), arr.end());
        string ans = "";
        do {
            int hour = arr[0] * 10 + arr[1];
            int minute = arr[2] * 10 + arr[3];
            if (hour < 24 && minute < 60) {
                string time = "";
                time += (arr[0] + '0');
                time += (arr[1] + '0');
                time += ":";
                time += (arr[2] + '0');
                time += (arr[3] + '0');
                if (ans < time) {
                    ans = time;
                }
            }
        } while (next_permutation(arr.begin(), arr.end()));

        return ans;
    }
};