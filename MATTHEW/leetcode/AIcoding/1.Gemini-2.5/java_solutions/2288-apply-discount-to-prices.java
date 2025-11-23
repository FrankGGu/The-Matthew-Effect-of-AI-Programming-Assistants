class Solution {
    public String discountPrices(String sentence, int discount) {
        String[] words = sentence.split(" ");
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            boolean isPrice = true;

            if (word.length() > 1 && word.charAt(0) == '$') {
                for (int j = 1; j < word.length(); j++) {
                    if (!Character.isDigit(word.charAt(j))) {
                        isPrice = false;
                        break;
                    }
                }
            } else {
                isPrice = false;
            }

            if (isPrice) {
                long priceValue = Long.parseLong(word.substring(1));
                double discountedPrice = priceValue * (100.0 - discount) / 100.0;
                result.append(String.format("$%.2f", discountedPrice));
            } else {
                result.append(word);
            }

            if (i < words.length - 1) {
                result.append(" ");
            }
        }

        return result.toString();
    }
}