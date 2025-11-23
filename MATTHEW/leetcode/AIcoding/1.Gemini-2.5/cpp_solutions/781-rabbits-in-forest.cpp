#include <vector>
#include <map>

class Solution {
public:
    int numRabbits(std::vector<int>& answers) {
        std::map<int, int> counts;
        for (int answer : answers) {
            counts[answer]++;
        }

        int totalRabbits = 0;
        for (auto const& pair : counts) {
            int answer_val = pair.first;
            int num_rabbits_giving_this_answer = pair.second;

            int group_size = answer_val + 1;

            int num_groups = (num_rabbits_giving_this_answer + group_size - 1) / group_size;

            totalRabbits += num_groups * group_size;
        }

        return totalRabbits;
    }
};