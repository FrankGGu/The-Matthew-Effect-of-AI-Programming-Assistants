class Solution {
    public List<List<String>> suggestedProducts(String[] products, String searchWord) {
        Arrays.sort(products);
        List<List<String>> result = new ArrayList<>();
        StringBuilder current = new StringBuilder();
        for (char c : searchWord.toCharArray()) {
            current.append(c);
            List<String> suggestions = new ArrayList<>();
            for (String product : products) {
                if (product.startsWith(current.toString())) {
                    suggestions.add(product);
                    if (suggestions.size() == 3) {
                        break;
                    }
                }
            }
            result.add(suggestions);
        }
        return result;
    }
}