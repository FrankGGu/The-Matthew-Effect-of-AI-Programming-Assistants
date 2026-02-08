#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minMeetingRooms(vector<vector<int>>& intervals) {
        if (intervals.empty()) {
            return 0;
        }

        vector<int> startTimes;
        vector<int> endTimes;

        for (const auto& interval : intervals) {
            startTimes.push_back(interval[0]);
            endTimes.push_back(interval[1]);
        }

        sort(startTimes.begin(), startTimes.end());
        sort(endTimes.begin(), endTimes.end());

        int rooms = 0;
        int endIndex = 0;

        for (int startTime : startTimes) {
            if (startTime < endTimes[endIndex]) {
                rooms++;
            } else {
                endIndex++;
            }
        }

        return rooms;
    }

    int minMeetingRooms_pq(vector<vector<int>>& intervals) {
        if (intervals.empty()) return 0;

        sort(intervals.begin(), intervals.end());

        priority_queue<int, vector<int>, greater<int>> pq;

        pq.push(intervals[0][1]);

        for (int i = 1; i < intervals.size(); ++i) {
            if (intervals[i][0] >= pq.top()) {
                pq.pop();
            }
            pq.push(intervals[i][1]);
        }

        return pq.size();
    }
    int minMeetingRooms_chairs(vector<vector<int>>& intervals) {
        vector<int> start, end;
        for (auto interval : intervals) {
            start.push_back(interval[0]);
            end.push_back(interval[1]);
        }

        sort(start.begin(), start.end());
        sort(end.begin(), end.end());

        int i = 0, j = 0, chairs = 0, maxChairs = 0;
        while (i < intervals.size() && j < intervals.size()) {
            if (start[i] < end[j]) {
                chairs++;
                maxChairs = max(maxChairs, chairs);
                i++;
            } else {
                chairs--;
                j++;
            }
        }

        return maxChairs;
    }

    int minMeetingRooms(vector<vector<int>>& meetings, int targetMeeting) {
      vector<int> start, end;
      for(auto meeting : meetings){
          start.push_back(meeting[0]);
          end.push_back(meeting[1]);
      }
      sort(start.begin(), start.end());
      sort(end.begin(), end.end());

      int ans = 0;
      int ongoing = 0;
      int i = 0, j = 0;
      while(i < meetings.size()){
          if(start[i] <= targetMeeting){
              if(start[i] < end[j]){
                  ongoing++;
                  i++;
              } else{
                  ongoing--;
                  j++;
              }
          } else {
              break;
          }
      }
      return ongoing;
    }
};