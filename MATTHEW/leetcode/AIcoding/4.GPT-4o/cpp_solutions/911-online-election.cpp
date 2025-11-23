class TopVotedCandidate {
public:
    vector<int> times;
    vector<int> leaders;
    TopVotedCandidate(vector<int>& persons, vector<int>& times) {
        int n = persons.size();
        unordered_map<int, int> count;
        int maxVotes = 0, leader = -1;

        for (int i = 0; i < n; ++i) {
            count[persons[i]]++;
            if (count[persons[i]] >= maxVotes) {
                maxVotes = count[persons[i]];
                leader = persons[i];
            }
            leaders.push_back(leader);
            this->times.push_back(times[i]);
        }
    }

    int q(int t) {
        int left = 0, right = times.size() - 1;
        while (left < right) {
            int mid = left + (right - left + 1) / 2;
            if (times[mid] <= t) left = mid;
            else right = mid - 1;
        }
        return leaders[left];
    }
};