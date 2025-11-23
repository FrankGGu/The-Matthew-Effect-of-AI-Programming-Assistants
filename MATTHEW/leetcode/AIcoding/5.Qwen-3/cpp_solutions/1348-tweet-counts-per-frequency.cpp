#include <iostream>
#include <vector>
#include <map>
#include <string>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<vector<int>> tweetCountsByFrequency(vector<string>& tweets, vector<int>& t, string& freq) {
        map<string, vector<int>> tweetTimeMap;
        for (int i = 0; i < tweets.size(); ++i) {
            tweetTimeMap[tweets[i]].push_back(t[i]);
        }

        vector<vector<int>> result;
        int interval = 0;
        if (freq == "minute") interval = 60;
        else if (freq == "hour") interval = 3600;
        else if (freq == "day") interval = 86400;

        for (auto& [tweet, times] : tweetTimeMap) {
            sort(times.begin(), times.end());
            vector<int> counts;
            int n = times.size();
            int i = 0;
            while (i < n) {
                int end = i;
                while (end < n && times[end] < times[i] + interval) {
                    end++;
                }
                counts.push_back(end - i);
                i = end;
            }
            result.push_back({{counts}});
        }

        return result;
    }
};