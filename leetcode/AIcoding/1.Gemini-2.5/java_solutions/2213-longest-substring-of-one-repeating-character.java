class Solution {
    class Node {
        int len;
        char prefixChar;
        int prefixLen;
        char suffixChar;
        int suffixLen;
        int maxLen;

        Node() {}

        Node(char c) {
            this.len = 1;
            this.prefixChar = c;
            this.prefixLen = 1;
            this.suffixChar = c;
            this.suffixLen = 1;
            this.maxLen = 1;
        }
    }

    class SegmentTree {
        Node[] tree;
        char[] arr;
        int N;

        SegmentTree(char[] inputArr) {
            this.arr = inputArr;
            this.N = inputArr.length;
            this.tree = new Node[4 * N];
            build(1, 0, N - 1);
        }

        Node merge(Node left, Node right) {
            Node res = new Node();
            res.len = left.len + right.len;

            res.prefixChar = left.prefixChar;
            res.prefixLen = left.prefixLen;
            if (left.prefixLen == left.len && left.prefixChar == right.prefixChar) {
                res.prefixLen += right.prefixLen;
            }

            res.suffixChar = right.suffixChar;
            res.suffixLen = right.suffixLen;
            if (right.suffixLen == right.len && right.suffixChar == left.suffixChar) {
                res.suffixLen += left.suffixLen;
            }

            res.maxLen = Math.max(left.maxLen, right.maxLen);
            if (left.suffixChar == right.prefixChar) {
                res.maxLen = Math.max(res.maxLen, left.suffixLen + right.prefixLen);
            }
            return res;
        }

        void build(int nodeIdx, int start, int end) {
            if (start == end) {
                tree[nodeIdx] = new Node(arr[start]);
            } else {
                int mid = (start + end) / 2;
                build(2 * nodeIdx, start, mid);
                build(2 * nodeIdx + 1, mid + 1, end);
                tree[nodeIdx] = merge(tree[2 * nodeIdx], tree[2 * nodeIdx + 1]);
            }
        }

        void update(int nodeIdx, int start, int end, int idx, char val) {
            if (start == end) {
                arr[idx] = val;
                tree[nodeIdx] = new Node(val);
            } else {
                int mid = (start + end) / 2;
                if (start <= idx && idx <= mid) {
                    update(2 * nodeIdx, start, mid, idx, val);
                } else {
                    update(2 * nodeIdx + 1, mid + 1, end, idx, val);
                }
                tree[nodeIdx] = merge(tree[2 * nodeIdx], tree[2 * nodeIdx + 1]);
            }
        }

        int query() {
            if (N == 0) return 0;
            return tree[1].maxLen;
        }
    }

    public int[] longestRepeatingSubstring(String s, String queryCharacters, int[] queryIndices) {
        char[] arr = s.toCharArray();
        SegmentTree st = new SegmentTree(arr);

        int numQueries = queryCharacters.length();
        int[] answers = new int[numQueries];

        for (int i = 0; i < numQueries; i++) {
            int idx = queryIndices[i];
            char val = queryCharacters.charAt(i);
            st.update(1, 0, st.N - 1, idx, val);
            answers[i] = st.query();
        }

        return answers;
    }
}