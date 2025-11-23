class Solution {
    class TrieNode {
        TrieNode[] children = new TrieNode[26];
        int index = -1;
    }

    public int[] stringIndices(String[] wordsContainer, String[] wordsQuery) {
        TrieNode root = new TrieNode();
        for (int i = 0; i < wordsContainer.length; i++) {
            String word = wordsContainer[i];
            TrieNode node = root;
            if (node.index == -1 || wordsContainer[node.index].length() > word.length()) {
                node.index = i;
            }
            for (int j = word.length() - 1; j >= 0; j--) {
                char c = word.charAt(j);
                if (node.children[c - 'a'] == null) {
                    node.children[c - 'a'] = new TrieNode();
                }
                node = node.children[c - 'a'];
                if (node.index == -1 || wordsContainer[node.index].length() > word.length()) {
                    node.index = i;
                }
            }
        }

        int[] result = new int[wordsQuery.length];
        for (int i = 0; i < wordsQuery.length; i++) {
            String word = wordsQuery[i];
            TrieNode node = root;
            int bestIndex = node.index;
            for (int j = word.length() - 1; j >= 0; j--) {
                char c = word.charAt(j);
                if (node.children[c - 'a'] == null) {
                    break;
                }
                node = node.children[c - 'a'];
                bestIndex = node.index;
            }
            result[i] = bestIndex;
        }
        return result;
    }
}