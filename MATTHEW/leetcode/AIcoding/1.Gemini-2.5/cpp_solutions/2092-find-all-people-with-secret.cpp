#include <vector>
#include <numeric>
#include <algorithm>
#include <set>

class DSU {
public:
    std::vector<int> parent;
    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0);
    }

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]);
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            parent[root_i] = root_j;
        }
    }

    void reset_person(int p) {
        parent[p] = p;
    }
};

class Solution {
public:
    std::vector<int> findAllPeople(int n, std::vector<std::vector<int>>& meetings, int firstPerson) {
        std::sort(meetings.begin(), meetings.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[2] < b[2];
        });

        std::vector<bool> secretKnown(n, false);
        secretKnown[0] = true;
        secretKnown[firstPerson] = true;

        DSU dsu(n);
        dsu.unite(0, firstPerson);

        int i = 0;
        while (i < meetings.size()) {
            int current_time = meetings[i][2];
            int j = i;
            std::set<int> people_in_current_time_group;

            while (j < meetings.size() && meetings[j][2] == current_time) {
                int p1 = meetings[j][0];
                int p2 = meetings[j][1];

                dsu.unite(p1, p2);

                people_in_current_time_group.insert(p1);
                people_in_current_time_group.insert(p2);
                j++;
            }

            for (int person_id : people_in_current_time_group) {
                if (secretKnown[person_id]) {
                    dsu.unite(person_id, 0);
                }
            }

            for (int person_id : people_in_current_time_group) {
                if (dsu.find(person_id) == dsu.find(0)) {
                    secretKnown[person_id] = true;
                } else {
                    dsu.reset_person(person_id); 
                }
            }

            i = j;
        }

        std::vector<int> result;
        for (int k = 0; k < n; ++k) {
            if (secretKnown[k]) {
                result.push_back(k);
            }
        }
        return result;
    }
};