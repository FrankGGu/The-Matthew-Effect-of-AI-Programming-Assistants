#include <vector>
#include <functional>

class Solution {
public:
    int dynamicPassword(std::vector<int>& password, int target, std::vector<std::vector<int>>& op) {
        int n = password.size();
        std::vector<int> inorder_nodes;
        inorder_nodes.reserve(n);

        std::function<void(int)> inorder_traversal = 
            [&](int u) {
            if (u >= n) {
                return;
            }
            inorder_traversal(2 * u + 1);
            inorder_nodes.push_back(u);
            inorder_traversal(2 * u + 2);
        };

        inorder_traversal(0);

        std::vector<int> node_to_inorder_idx(n);
        for (int i = 0; i < n; ++i) {
            node_to_inorder_idx[inorder_nodes[i]] = i;
        }

        int current_node = 0;
        int current_inorder_idx = node_to_inorder_idx[current_node];

        for (int i = 0; i < op.size(); ++i) {
            int type = op[i][0];
            int val = op[i][1];

            if (type == 0) {
                current_inorder_idx = (current_inorder_idx + val) % n;
            } else {
                current_inorder_idx = (current_inorder_idx - (val % n) + n) % n;
            }

            current_node = inorder_nodes[current_inorder_idx];

            if (password[current_node] == target) {
                return i + 1;
            }
        }

        return -1;
    }
};