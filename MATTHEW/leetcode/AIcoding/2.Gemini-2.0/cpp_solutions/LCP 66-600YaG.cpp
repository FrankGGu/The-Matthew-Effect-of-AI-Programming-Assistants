#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minStands(vector<string>& events) {
        vector<int> start_times;
        vector<int> end_times;

        for (const string& event : events) {
            string start_str = event.substr(0, event.find(' '));
            string end_str = event.substr(event.find(' ') + 1);

            int start_time = stoi(start_str);
            int end_time = stoi(end_str);

            start_times.push_back(start_time);
            end_times.push_back(end_time);
        }

        sort(start_times.begin(), start_times.end());
        sort(end_times.begin(), end_times.end());

        int stands = 0;
        int start_ptr = 0;
        int end_ptr = 0;

        while (start_ptr < start_times.size()) {
            if (start_times[start_ptr] > end_times[end_ptr]) {
                stands--;
                end_ptr++;
            }
            stands++;
            start_ptr++;
        }

        return stands;
    }
};