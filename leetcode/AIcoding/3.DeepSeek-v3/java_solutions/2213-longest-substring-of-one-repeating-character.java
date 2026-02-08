class Solution {
    public int[] longestRepeating(String s, String queryCharacters, int[] queryIndices) {
        char[] chars = s.toCharArray();
        int n = chars.length;
        int k = queryCharacters.length();
        int[] res = new int[k];
        SegmentTree st = new SegmentTree(chars);

        for (int i = 0; i < k; i++) {
            int pos = queryIndices[i];
            char c = queryCharacters.charAt(i);
            st.update(pos, c);
            res[i] = st.query();
        }
        return res;
    }

    class SegmentTree {
        private int n;
        private Node[] tree;

        public SegmentTree(char[] chars) {
            this.n = chars.length;
            this.tree = new Node[4 * n];
            build(0, 0, n - 1, chars);
        }

        private void build(int node, int start, int end, char[] chars) {
            if (start == end) {
                tree[node] = new Node(1, 1, 1, chars[start], chars[end]);
                return;
            }
            int mid = (start + end) / 2;
            build(2 * node + 1, start, mid, chars);
            build(2 * node + 2, mid + 1, end, chars);
            tree[node] = merge(tree[2 * node + 1], tree[2 * node + 2]);
        }

        public void update(int pos, char c) {
            update(0, 0, n - 1, pos, c);
        }

        private void update(int node, int start, int end, int pos, char c) {
            if (start == end) {
                tree[node] = new Node(1, 1, 1, c, c);
                return;
            }
            int mid = (start + end) / 2;
            if (pos <= mid) {
                update(2 * node + 1, start, mid, pos, c);
            } else {
                update(2 * node + 2, mid + 1, end, pos, c);
            }
            tree[node] = merge(tree[2 * node + 1], tree[2 * node + 2]);
        }

        public int query() {
            return tree[0].max;
        }

        private Node merge(Node left, Node right) {
            int max = Math.max(left.max, right.max);
            int prefix = left.prefix;
            int suffix = right.suffix;
            char leftChar = left.leftChar;
            char rightChar = right.rightChar;

            if (left.rightChar == right.leftChar) {
                max = Math.max(max, left.suffix + right.prefix);
                if (left.prefix == left.size) {
                    prefix = left.prefix + right.prefix;
                }
                if (right.suffix == right.size) {
                    suffix = right.suffix + left.suffix;
                }
            }

            return new Node(max, prefix, suffix, leftChar, rightChar, left.size + right.size);
        }

        class Node {
            int max, prefix, suffix, size;
            char leftChar, rightChar;

            public Node(int max, int prefix, int suffix, char leftChar, char rightChar) {
                this(max, prefix, suffix, leftChar, rightChar, 1);
            }

            public Node(int max, int prefix, int suffix, char leftChar, char rightChar, int size) {
                this.max = max;
                this.prefix = prefix;
                this.suffix = suffix;
                this.leftChar = leftChar;
                this.rightChar = rightChar;
                this.size = size;
            }
        }
    }
}