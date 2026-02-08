import java.util.Deque;
import java.util.LinkedList;

class TrieNode {
    TrieNode[] children;
    boolean isWord;

    public TrieNode() {
        children = new TrieNode[26];
        isWord = false;
    }
}

class StreamChecker {
    private TrieNode root;
    private Deque<Character> stream;
    private int maxWordLength;

    public StreamChecker(String[] words) {
        root = new TrieNode();
        stream = new LinkedList<>();
        maxWordLength = 0;

        for (String word : words) {
            maxWordLength = Math.max(maxWordLength, word.length());
            TrieNode current = root;
            for (int i = word.length() - 1; i >= 0; i--) {
                char c = word.charAt(i);
                if (current.children[c - 'a'] == null) {
                    current.children[c - 'a'] = new TrieNode();
                }
                current = current.children[c - 'a'];
            }
            current.isWord = true;
        }
    }

    public boolean query(char letter) {
        stream.addFirst(letter);

        if (stream.size() > maxWordLength) {
            stream.removeLast();
        }

        TrieNode current = root;
        for (char c : stream) {
            if (current.children[c - 'a'] == null) {
                return false;
            }
            current = current.children[c - 'a'];
            if (current.isWord) {
                return true;
            }
        }
        return false;
    }
}