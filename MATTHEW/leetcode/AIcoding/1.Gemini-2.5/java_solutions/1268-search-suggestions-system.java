import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {

    static class TrieNode {
        Map<Character, TrieNode> children = new HashMap<>();
        List<String> suggestions = new ArrayList<>();

        void addSuggestion(String product) {
            if (suggestions.size() < 3) {
                suggestions.add(product);
            }
        }
    }

    public List<List<String>> suggestedProducts(String[] products, String searchWord) {
        Arrays.sort(products);

        TrieNode root = new TrieNode();
        for (String product : products) {
            TrieNode curr = root;
            for (char c : product.toCharArray()) {
                curr.children.computeIfAbsent(c, k -> new TrieNode());
                curr = curr.children.get(c);
                curr.addSuggestion(product);
            }
        }

        List<List<String>> result = new ArrayList<>();
        TrieNode curr = root;
        for (char c : searchWord.toCharArray()) {
            if (curr != null) {
                curr = curr.children.get(c);
            }

            if (curr == null) {
                result.add(new ArrayList<>());
            } else {
                result.add(new ArrayList<>(curr.suggestions));
            }
        }

        return result;
    }
}