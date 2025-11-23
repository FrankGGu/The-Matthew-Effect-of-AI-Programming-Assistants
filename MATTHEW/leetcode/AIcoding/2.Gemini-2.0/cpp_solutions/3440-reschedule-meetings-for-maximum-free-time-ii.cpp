#include <vector>
#include <algorithm>

using namespace std;

struct Interval {
  int start, end;
};

int maxFreeTime(vector<vector<Interval>>& meetings) {
  vector<pair<int, int>> events;
  for (auto& personMeetings : meetings) {
    for (auto& meeting : personMeetings) {
      events.push_back({meeting.start, 1}); // 1 for start
      events.push_back({meeting.end, -1});  // -1 for end
    }
  }

  sort(events.begin(), events.end());

  int count = 0;
  int maxGap = 0;
  int prevTime = 0;
  for (auto& event : events) {
    if (count == 0 && prevTime != 0) {
      maxGap = max(maxGap, event.first - prevTime);
    }
    count += event.second;
    prevTime = event.first;
  }

  return maxGap;
}