class Solution {
    public int countPairs(int[] nums, int low, int high) {
        Trie trie = new Trie();
        int count = 0;
        for (int num : nums) {
            count += trie.countLessThanOrEqualTo(num, high) - trie.countLessThanOrEqualTo(num, low - 1);
            trie.insert(num);
        }
        return count;
    }

    private static class Trie {
        private Node root;

        public Trie() {
            root = new Node();
        }

        public void insert(int num) {
            Node curr = root;
            for (int i = 14; i >= 0; i--) {
                int bit = (num >> i) & 1;
                if (curr.children[bit] == null) {
                    curr.children[bit] = new Node();
                }
                curr = curr.children[bit];
                curr.count++;
            }
        }

        public int countLessThanOrEqualTo(int num, int k) {
            Node curr = root;
            int count = 0;
            for (int i = 14; i >= 0; i--) {
                int numBit = (num >> i) & 1;
                int kBit = (k >> i) & 1;

                if (kBit == 1) {
                    if (curr.children[numBit] != null) {
                        count += curr.children[numBit].count;
                    }
                    if (curr.children[1 - numBit] == null) {
                        return count;
                    }
                    curr = curr.children[1 - numBit];
                } else {
                    if (curr.children[numBit] == null) {
                        return count;
                    }
                    curr = curr.children[numBit];
                }
                if (curr == null) return 0;
            }
            return count + curr.count;
        }

        private static class Node {
            Node[] children;
            int count;

            public Node() {
                children = new Node[2];
                count = 0;
            }
        }
    }
}