class MapSum {

    private class Node {
        int val;
        Node[] children;
        boolean isWord;

        Node() {
            val = 0;
            children = new Node[26];
            isWord = false;
        }
    }

    private Node root;
    private HashMap<String, Integer> map;

    public MapSum() {
        root = new Node();
        map = new HashMap<>();
    }

    public void insert(String key, int val) {
        int delta = val - map.getOrDefault(key, 0);
        map.put(key, val);

        Node cur = root;
        for (int i = 0; i < key.length(); i++) {
            char c = key.charAt(i);
            int index = c - 'a';
            if (cur.children[index] == null) {
                cur.children[index] = new Node();
            }
            cur = cur.children[index];
            cur.val += delta;
        }
        cur.isWord = true;
    }

    public int sum(String prefix) {
        Node cur = root;
        for (int i = 0; i < prefix.length(); i++) {
            char c = prefix.charAt(i);
            int index = c - 'a';
            if (cur.children[index] == null) {
                return 0;
            }
            cur = cur.children[index];
        }
        return cur.val;
    }
}