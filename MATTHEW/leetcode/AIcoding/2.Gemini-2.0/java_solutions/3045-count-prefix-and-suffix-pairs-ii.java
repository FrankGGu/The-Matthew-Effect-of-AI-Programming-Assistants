class Solution {
    public long countPrefixSuffixPairs(String[] words) {
        TrieNode trie = new TrieNode();
        long count = 0;
        for (String word : words) {
            count += insert(trie, word);
        }
        return count;
    }

    private long insert(TrieNode trie, String word) {
        long count = 0;
        TrieNode curr = trie;
        for (int i = 0; i < word.length(); i++) {
            int index = word.charAt(i) - 'a';
            if (curr.children[index] == null) {
                curr.children[index] = new TrieNode();
            }
            curr = curr.children[index];
            if (isPrefixAndSuffix(word, i + 1)) {
                count += curr.count;
            }
        }
        curr.count++;
        return count;
    }

    private boolean isPrefixAndSuffix(String word, int len) {
        if (len > word.length()) return false;
        for (int i = 0; i < len; i++) {
            if (word.charAt(i) != word.charAt(word.length() - len + i)) {
                return false;
            }
        }
        return true;
    }

    static class TrieNode {
        TrieNode[] children = new TrieNode[26];
        int count = 0;
    }
}