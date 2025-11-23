class Solution {
    public String discountPrices(String sentence, int discount) {
        String[] words = sentence.split(" ");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            if (word.startsWith("$") && word.length() > 1) {
                try {
                    long price = Long.parseLong(word.substring(1));
                    double discountedPrice = price * (100.0 - discount) / 100.0;
                    sb.append("$").append(String.format("%.2f", discountedPrice));
                } catch (NumberFormatException e) {
                    sb.append(word);
                }
            } else {
                sb.append(word);
            }
            if (i < words.length - 1) {
                sb.append(" ");
            }
        }
        return sb.toString();
    }
}