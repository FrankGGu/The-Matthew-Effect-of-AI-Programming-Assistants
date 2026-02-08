#include <vector>
#include <string>
#include <numeric>
#include <map>
#include <algorithm>

class Solution {
public:
    std::vector<int> parent;
    std::vector<int> sz;
    int num_groups;
    int max_group_size;

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]);
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            if (sz[root_i] < sz[root_j])
                std::swap(root_i, root_j);
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
            num_groups--;
            max_group_size = std::max(max_group_size, sz[root_i]);
        }
    }

    std::vector<int> groupsOfStrings(std::vector<std::string>& words) {
        int N = words.size();
        if (N == 0) {
            return {0, 0};
        }

        parent.resize(N);
        std::iota(parent.begin(), parent.end(), 0);
        sz.assign(N, 1);
        num_groups = N;
        max_group_size = 1;

        std::map<int, int> mask_to_first_idx; 

        for (int i = 0; i < N; ++i) {
            int current_mask = 0;
            for (char c : words[i]) {
                current_mask |= (1 << (c - 'a'));
            }

            if (mask_to_first_idx.count(current_mask)) {
                unite(i, mask_to_first_idx[current_mask]);
            } else {
                mask_to_first_idx[current_mask] = i;
            }

            for (int k = 0; k < 26; ++k) {
                if ((current_mask >> k) & 1) { 
                    int target_mask_delete = current_mask ^ (1 << k);
                    if (mask_to_first_idx.count(target_mask_delete)) {
                        unite(i, mask_to_first_idx[target_mask_delete]);
                    }
                }
            }

            for (int k1 = 0; k1 < 26; ++k1) {
                if ((current_mask >> k1) & 1) { 
                    for (int k2 = 0; k2 < 26; ++k2) {
                        if (!((current_mask >> k2) & 1)) { 
                            int target_mask_change = current_mask ^ (1 << k1) | (1 << k2);
                            if (mask_to_first_idx.count(target_mask_change)) {
                                unite(i, mask_to_first_idx[target_mask_change]);
                            }
                        }
                    }
                }
            }
        }

        return {num_groups, max_group_size};
    }
};