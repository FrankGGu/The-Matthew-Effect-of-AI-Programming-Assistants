#include <vector>
#include <unordered_set>
#include <algorithm> // For std::min

class Solution {
public:
    int minimumTeachings(int n, int m, std::vector<std::vector<int>>& languages, std::vector<std::vector<int>>& friendships) {
        std::vector<std::unordered_set<int>> person_languages_set(n + 1);
        for (int i = 0; i < n; ++i) {
            for (int lang : languages[i]) {
                person_languages_set[i + 1].insert(lang);
            }
        }

        std::unordered_set<int> people_involved_in_issues;

        for (const auto& friendship_pair : friendships) {
            int u = friendship_pair[0];
            int v = friendship_pair[1];

            bool can_communicate = false;
            const std::unordered_set<int>& langs_u = person_languages_set[u];
            const std::unordered_set<int>& langs_v = person_languages_set[v];

            if (langs_u.size() > langs_v.size()) {
                for (int lang : langs_v) {
                    if (langs_u.count(lang)) {
                        can_communicate = true;
                        break;
                    }
                }
            } else {
                for (int lang : langs_u) {
                    if (langs_v.count(lang)) {
                        can_communicate = true;
                        break;
                    }
                }
            }

            if (!can_communicate) {
                people_involved_in_issues.insert(u);
                people_involved_in_issues.insert(v);
            }
        }

        if (people_involved_in_issues.empty()) {
            return 0;
        }

        int min_people_taught = n + 1; 

        for (int lang_to_teach = 1; lang_to_teach <= m; ++lang_to_teach) {
            int current_people_taught_for_this_lang = 0;
            for (int person_id : people_involved_in_issues) {
                if (person_languages_set[person_id].count(lang_to_teach) == 0) {
                    current_people_taught_for_this_lang++;
                }
            }
            min_people_taught = std::min(min_people_taught, current_people_taught_for_this_lang);
        }

        return min_people_taught;
    }
};