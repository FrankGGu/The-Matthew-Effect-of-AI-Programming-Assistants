class Solution {
    public int minimumLengthEncoding(String[] words) {
        TrieNode root = new TrieNode();
        int count = 0;
        for (String word : words) {
            TrieNode node = root;
            for (int i = word.length() - 1; i >= 0; i--) {
                char c = word.charAt(i);
                if (node.children[c - 'a'] == null) {
                    node.children[c - 'a'] = new TrieNode();
                }
                node = node.children[c - 'a'];
            }
            node.word = word;
        }

        for (String word : words) {
            TrieNode node = root;
            boolean isLeaf = true;
            for (int i = word.length() - 1; i >= 0; i--) {
                char c = word.charAt(i);
                node = node.children[c - 'a'];
                if (node.word != null && !node.word.equals(word)) {
                  isLeaf = false;
                  break;
                }
                boolean hasChildren = false;
                for (int j = 0; j < 26; j++) {
                    if (node.children[j] != null) {
                        hasChildren = true;
                        break;
                    }
                }
                if(hasChildren){
                    isLeaf = false;
                    break;
                }
            }
            if (isLeaf) {
                count += word.length() + 1;
            }
        }

        TrieNode root2 = new TrieNode();
        int count2 = 0;
        Arrays.sort(words, (a, b) -> b.length() - a.length());

        for (String word : words) {
            TrieNode node = root2;
            boolean isNew = false;
            for (int i = word.length() - 1; i >= 0; i--) {
                char c = word.charAt(i);
                if (node.children[c - 'a'] == null) {
                    node.children[c - 'a'] = new TrieNode();
                    isNew = true;
                }
                node = node.children[c - 'a'];
            }
            if (isNew) {
                count2 += word.length() + 1;
            }
        }
        return count2;
    }

    static class TrieNode {
        TrieNode[] children = new TrieNode[26];
        String word;
    }
}