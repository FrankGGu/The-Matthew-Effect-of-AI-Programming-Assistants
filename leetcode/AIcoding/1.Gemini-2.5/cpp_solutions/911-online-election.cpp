#include <vector>
#include <map>
#include <algorithm>

class TopVotedCandidate {
public:
    std::vector<std::pair<int, int>> leading_candidates_at_time;

    TopVotedCandidate(std::vector<int>& persons, std::vector<int>& times) {
        std::map<int, int> vote_counts;
        int current_leader = -1;
        int max_votes = 0;

        for (size_t i = 0; i < persons.size(); ++i) {
            int person = persons[i];
            int time = times[i];

            vote_counts[person]++;
            int current_person_votes = vote_counts[person];

            if (current_person_votes >= max_votes) {
                max_votes = current_person_votes;
                current_leader = person;
            }

            leading_candidates_at_time.push_back({time, current_leader});
        }
    }

    int q(int t) {
        auto it = std::upper_bound(leading_candidates_at_time.begin(), leading_candidates_at_time.end(), t, 
                                   [](int query_time, const std::pair<int, int>& p){
                                       return query_time < p.first;
                                   });

        --it; 

        return it->second;
    }
};