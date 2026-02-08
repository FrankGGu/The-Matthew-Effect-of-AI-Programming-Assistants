use std::collections::HashSet;

struct DSU {
    parent: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            self.parent[i] = self.find(self.parent[i]);
            self.parent[i]
        }
    }

    fn union(&mut self, i: usize, j: usize) {
        let root_i = self.find(i);
        let root_j = self.find(j);
        if root_i != root_j {
            self.parent[root_j] = root_i;
        }
    }

    fn reset(&mut self, i: usize) {
        self.parent[i] = i;
    }
}

impl Solution {
    pub fn find_all_people(n: i32, meetings: Vec<Vec<i32>>, first_person: i32) -> Vec<i32> {
        let n = n as usize;
        let first_person = first_person as usize;

        let mut meetings_sorted = meetings;
        meetings_sorted.sort_by_key(|m| m[2]); // Sort meetings by time

        let mut dsu = DSU::new(n);
        let mut secret_known_flags = vec![false; n];

        // Initially, person 0 and firstPerson know the secret
        secret_known_flags[0] = true;
        secret_known_flags[first_person] = true;

        // If 0 and firstPerson are distinct, they are connected from time 0
        if 0 != first_person {
            dsu.union(0, first_person);
        }

        let mut i = 0;
        while i < meetings_sorted.len() {
            let current_time = meetings_sorted[i][2];
            let mut people_involved_in_current_time_slice = Vec::new();
            let mut j = i;

            // Process all meetings that happen at the current_time
            while j < meetings_sorted.len() && meetings_sorted[j][2] == current_time {
                let p1 = meetings_sorted[j][0] as usize;
                let p2 = meetings_sorted[j][1] as usize;

                dsu.union(p1, p2);

                people_involved_in_current_time_slice.push(p1);
                people_involved_in_current_time_slice.push(p2);
                j += 1;
            }

            // After all unions for current_time are done:
            // Determine which connected components (roots) know the secret based on current `secret_known_flags`
            let mut roots_knowing_secret_this_round: HashSet<usize> = HashSet::new();
            for &p in &people_involved_in_current_time_slice {
                if secret_known_flags[p] {
                    roots_knowing_secret_this_round.insert(dsu.find(p));
                }
            }

            // Propagate the secret within components and reset DSU for those who don't learn
            for &p in &people_involved_in_current_time_slice {
                if roots_knowing_secret_this_round.contains(&dsu.find(p)) {
                    secret_known_flags[p] = true;
                } else {
                    // If this person's component does not know the secret,
                    // their connections formed at this time are temporary.
                    // Reset their DSU parent to themselves.
                    dsu.reset(p);
                }
            }

            i = j; // Move to the next time slice
        }

        // Collect all people who know the secret
        let mut result = Vec::new();
        for p in 0..n {
            if secret_known_flags[p] {
                result.push(p as i32);
            }
        }
        result
    }
}