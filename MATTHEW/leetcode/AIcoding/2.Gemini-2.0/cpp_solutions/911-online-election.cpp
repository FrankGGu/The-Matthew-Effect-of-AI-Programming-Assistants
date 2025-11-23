#include <vector>
#include <map>

using namespace std;

class TopVotedCandidate {
public:
    TopVotedCandidate(vector<int>& persons, vector<int>& times) {
        this->persons = persons;
        this->times = times;

        map<int, int> votes;
        int leader = -1;
        int maxVotes = -1;

        for (int person : persons) {
            votes[person]++;
            if (votes[person] >= maxVotes) {
                maxVotes = votes[person];
                leader = person;
            }
            leaders.push_back(leader);
        }
    }

    int q(int t) {
        int left = 0;
        int right = times.size() - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (times[mid] == t) {
                return leaders[mid];
            } else if (times[mid] < t) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return leaders[right];
    }

private:
    vector<int> persons;
    vector<int> times;
    vector<int> leaders;
};