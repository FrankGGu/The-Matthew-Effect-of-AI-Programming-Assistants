class Solution {
public:
    int minimumTeachings(int n, vector<vector<int>>& languages, vector<vector<int>>& friendships) {
        vector<unordered_set<int>> lang(n + 1);
        for (int i = 0; i < languages.size(); ++i) {
            for (int lang_id : languages[i]) {
                lang[lang_id].insert(i + 1);
            }
        }

        unordered_set<int> cannot_communicate;
        for (const auto& friendship : friendships) {
            int personA = friendship[0], personB = friendship[1];
            bool canCommunicate = false;
            for (int langA : languages[personA - 1]) {
                for (int langB : languages[personB - 1]) {
                    if (langA == langB) {
                        canCommunicate = true;
                        break;
                    }
                }
                if (canCommunicate) break;
            }
            if (!canCommunicate) {
                cannot_communicate.insert(personA);
                cannot_communicate.insert(personB);
            }
        }

        if (cannot_communicate.empty()) return 0;

        vector<int> teach_count(101, 0);
        for (int person : cannot_communicate) {
            for (int lang_id : languages[person - 1]) {
                teach_count[lang_id]++;
            }
        }

        return *max_element(teach_count.begin(), teach_count.end());
    }
};