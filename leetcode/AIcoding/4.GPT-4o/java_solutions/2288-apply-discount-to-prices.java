class Solution {
    public String discountPrices(String sentence, int discount) {
        String[] words = sentence.split(" ");
        StringBuilder result = new StringBuilder();

        for (String word : words) {
            if (word.length() > 1 && word.charAt(0) == '$') {
                String priceStr = word.substring(1);
                try {
                    double price = Double.parseDouble(priceStr);
                    double discountedPrice = price * (1 - discount / 100.0);
                    result.append("$").append(String.format("%.2f", discountedPrice)).append(" ");
                } catch (NumberFormatException e) {
                    result.append(word).append(" ");
                }
            } else {
                result.append(word).append(" ");
            }
        }

        return result.toString().trim();
    }
}