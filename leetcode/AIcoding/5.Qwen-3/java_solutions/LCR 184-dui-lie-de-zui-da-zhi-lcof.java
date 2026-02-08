public class Solution {

import java.util.*;

public class Solution {
    public int[] getFoodSuggestions(String[] products, String searchWord) {
        List<String> suggestions = new ArrayList<>();
        Arrays.sort(products);
        for (int i = 0; i < searchWord.length(); i++) {
            String prefix = searchWord.substring(0, i + 1);
            List<String> temp = new ArrayList<>();
            for (String product : products) {
                if (product.startsWith(prefix)) {
                    temp.add(product);
                }
            }
            if (temp.size() > 3) {
                temp = temp.subList(0, 3);
            }
            suggestions.addAll(temp);
        }
        int[] result = new int[suggestions.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = suggestions.get(i);
        }
        return result;
    }
}
}