import java.util.HashMap;
import java.util.Map;

class MapSum {

    private TrieNode root;
    private Map<String, Integer> keyToValMap;

    class TrieNode {
        TrieNode[] children;
        int sum;

        TrieNode() {
            children = new TrieNode[26];
            sum = 0;
        }
    }

    public MapSum() {
        root = new TrieNode();
        keyToValMap = new HashMap<>();
    }

    public void insert(String key, int val) {
        int oldValue = keyToValMap.getOrDefault(key, 0);
        keyToValMap.put(key, val);

        int delta = val - oldValue;

        TrieNode current = root;
        for (char c : key.toCharArray()) {
            int index = c - 'a';
            if (current.children[index] == null) {
                current.children[index] = new TrieNode();
            }
            current = current.children[index];
            current.sum += delta;
        }
    }

    public int sum(String prefix) {
        TrieNode current = root;
        for (char c : prefix.toCharArray()) {
            int index = c - 'a';
            if (current.children[index] == null) {
                return 0;
            }
            current = current.children[index];
        }
        return current.sum;
    }
}