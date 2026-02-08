import java.util.HashMap;
import java.util.Map;

class MapSum {

    private static class TrieNode {
        TrieNode[] children;
        int sum;

        public TrieNode() {
            children = new TrieNode[26];
            sum = 0;
        }
    }

    private TrieNode root;
    private Map<String, Integer> keyValues;

    public MapSum() {
        root = new TrieNode();
        keyValues = new HashMap<>();
    }

    public void insert(String key, int val) {
        int oldVal = keyValues.getOrDefault(key, 0);
        int delta = val - oldVal;

        keyValues.put(key, val);

        TrieNode curr = root;
        for (char c : key.toCharArray()) {
            int index = c - 'a';
            if (curr.children[index] == null) {
                curr.children[index] = new TrieNode();
            }
            curr = curr.children[index];
            curr.sum += delta;
        }
    }

    public int sum(String prefix) {
        TrieNode curr = root;
        for (char c : prefix.toCharArray()) {
            int index = c - 'a';
            if (curr.children[index] == null) {
                return 0;
            }
            curr = curr.children[index];
        }
        return curr.sum;
    }
}