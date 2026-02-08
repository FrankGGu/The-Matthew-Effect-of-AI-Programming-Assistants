class Solution {
    private final String[] LESS_THAN_20 = {"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};
    private final String[] TENS = {"", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};
    private final String[] THOUSANDS = {"", "Thousand", "Million", "Billion"};

    public String numberToWords(int num) {
        if (num == 0) {
            return "Zero";
        }

        StringBuilder result = new StringBuilder();
        int i = 0; // Index for THOUSANDS array (0: units, 1: thousands, 2: millions, 3: billions)

        while (num > 0) {
            if (num % 1000 != 0) {
                // Prepend the words for the current three-digit group and its magnitude
                result.insert(0, helper(num % 1000) + " " + THOUSANDS[i] + " ");
            }
            num /= 1000;
            i++;
        }

        return result.toString().trim(); // Trim any leading/trailing spaces
    }

    // Helper function to convert a number less than 1000 into words
    private String helper(int num) {
        if (num == 0) {
            return "";
        } else if (num < 20) {
            return LESS_THAN_20[num];
        } else if (num < 100) {
            // e.g., 21 -> "Twenty One", 30 -> "Thirty"
            return TENS[num / 10] + (num % 10 != 0 ? " " + LESS_THAN_20[num % 10] : "");
        } else { // num < 1000
            // e.g., 123 -> "One Hundred Twenty Three", 500 -> "Five Hundred"
            return LESS_THAN_20[num / 100] + " Hundred" + (num % 100 != 0 ? " " + helper(num % 100) : "");
        }
    }
}