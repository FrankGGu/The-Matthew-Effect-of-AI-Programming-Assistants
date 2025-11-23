import java.util.List;

class Solution {
    public String replaceWords(List<String> dictionary, String sentence) {
        TrieNode root = new TrieNode();
        for (String dictWord : dictionary) {
            TrieNode node = root;
            for (char c : dictWord.toCharArray()) {
                int index = c - 'a';
                if (node.children[index] == null) {
                    node.children[index] = new TrieNode();
                }
                node = node.children[index];
            }
            node.isWord = true;
        }

        String[] words = sentence.split(" ");
        StringBuilder result = new StringBuilder();

        for (String word : words) {
            TrieNode node = root;
            StringBuilder currentPrefix = new StringBuilder();
            String foundRoot = null;

            for (char c : word.toCharArray()) {
                int index = c - 'a';
                if (node.children[index] == null) {
                    break;
                }
                node = node.children[index];
                currentPrefix.append(c);
                if (node.isWord) {
                    foundRoot = currentPrefix.toString();
                    break;
                }
            }

            if (foundRoot != null) {
                result.append(foundRoot);
            } else {
                result.append(word);
            }
            result.append(" ");
        }

        if (result.length() > 0) {
            result.setLength(result.length() - 1);
        }

        return result.toString();
    }

    private static class TrieNode {
        TrieNode[] children;
        boolean isWord;

        public TrieNode() {
            children = new TrieNode[26];
            isWord = false;
        }
    }
}