class Solution {
    public int numMatchingSubseq(String s, String[] words) {
        List<Node>[] heads = new ArrayList[26];
        for (int i = 0; i < 26; i++) {
            heads[i] = new ArrayList<>();
        }
        for (String word : words) {
            heads[word.charAt(0) - 'a'].add(new Node(word, 0));
        }
        int res = 0;
        for (char c : s.toCharArray()) {
            List<Node> old = heads[c - 'a'];
            heads[c - 'a'] = new ArrayList<>();
            for (Node node : old) {
                node.index++;
                if (node.index == node.word.length()) {
                    res++;
                } else {
                    heads[node.word.charAt(node.index) - 'a'].add(node);
                }
            }
            old.clear();
        }
        return res;
    }
}

class Node {
    String word;
    int index;
    public Node(String word, int index) {
        this.word = word;
        this.index = index;
    }
}