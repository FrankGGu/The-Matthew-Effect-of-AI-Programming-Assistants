class TopVotedCandidate {
private:
    vector<int> times;
    vector<int> leaders;

public:
    TopVotedCandidate(vector<int>& persons, vector<int>& times) {
        this->times = times;
        unordered_map<int, int> count;
        int leader = -1;
        for (int i = 0; i < persons.size(); ++i) {
            int p = persons[i];
            count[p]++;
            if (i == 0 || count[p] >= count[leader]) {
                leader = p;
            }
            leaders.push_back(leader);
        }
    }

    int q(int t) {
        int left = 0, right = times.size() - 1;
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
};