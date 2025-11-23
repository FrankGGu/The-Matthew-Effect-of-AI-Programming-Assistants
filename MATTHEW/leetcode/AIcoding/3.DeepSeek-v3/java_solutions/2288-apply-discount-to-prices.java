class Solution {
    public String discountPrices(String sentence, int discount) {
        String[] words = sentence.split(" ");
        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            if (word.startsWith("$") && word.length() > 1) {
                try {
                    long num = Long.parseLong(word.substring(1));
                    double discounted = num * (100 - discount) / 100.0;
                    words[i] = String.format("$%.2f", discounted);
                } catch (NumberFormatException e) {
                    continue;
                }
            }
        }
        return String.join(" ", words);
    }
}