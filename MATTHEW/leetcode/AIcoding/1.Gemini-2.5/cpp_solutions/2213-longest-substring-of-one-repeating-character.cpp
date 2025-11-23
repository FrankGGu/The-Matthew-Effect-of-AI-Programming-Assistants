#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    struct Node {
        int len;
        int pre_len;
        int suf_len;
        int max_len;
        char pre_char;
        char suf_char;

        Node(int l = 0, int pl = 0, int sl = 0, int ml = 0, char pc = 0, char sc = 0)
            : len(l), pre_len(pl), suf_len(sl), max_len(ml), pre_char(pc), suf_char(sc) {}
    };

    std::string s_orig;
    std::vector<Node> tree;

    Node merge(const Node& left, const Node& right) {
        Node res;
        res.len = left.len + right.len;

        res.pre_char = left.pre_char;
        res.suf_char = right.suf_char;

        res.pre_len = left.pre_len;
        if (left.pre_len == left.len && left.suf_char == right.pre_char) {
            res.pre_len += right.pre_len;
        }

        res.suf_len = right.suf_len;
        if (right.suf_len == right.len && right.pre_char == left.suf_char) {
            res.suf_len += left.suf_len;
        }

        res.max_len = std::max(left.max_len, right.max_len);
        if (left.suf_char == right.pre_char) {
            res.max_len = std::max(res.max_len, left.suf_len + right.pre_len);
        }
        return res;
    }

    void build(int node_idx, int start, int end) {
        if (start == end) {
            tree[node_idx] = Node(1, 1, 1, 1, s_orig[start], s_orig[start]);
        } else {
            int mid = start + (end - start) / 2;
            build(2 * node_idx, start, mid);
            build(2 * node_idx + 1, mid + 1, end);
            tree[node_idx] = merge(tree[2 * node_idx], tree[2 * node_idx + 1]);
        }
    }

    void update(int node_idx, int start, int end, int idx, char val) {
        if (start == end) {
            tree[node_idx] = Node(1, 1, 1, 1, val, val);
        } else {
            int mid = start + (end - start) / 2;
            if (start <= idx && idx <= mid) {
                update(2 * node_idx, start, mid, idx, val);
            } else {
                update(2 * node_idx + 1, mid + 1, end, idx, val);
            }
            tree[node_idx] = merge(tree[2 * node_idx], tree[2 * node_idx + 1]);
        }
    }

    std::vector<int> longestRepeatingSubstring(std::string s, std::string queryCharacters, std::vector<int>& queryIndices) {
        s_orig = s;
        int n = s.length();
        tree.resize(4 * n);
        build(1, 0, n - 1);

        std::vector<int> results;
        for (int i = 0; i < queryCharacters.length(); ++i) {
            int idx = queryIndices[i];
            char val = queryCharacters[i];
            update(1, 0, n - 1, idx, val);
            results.push_back(tree[1].max_len);
        }
        return results;
    }
};